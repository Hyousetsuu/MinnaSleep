import { prisma } from '../../../core/database/prisma.js';
import { ErrorFactory } from '../../../core/api/error_factory.js';
import { Clock } from '../../../core/utils/clock.js';
import { logger } from '../../../logger.js';

export class AIQuotaService {
  /**
   * Validates if the user has enough AI quota for the day/month.
   * Decrements quota if successful.
   * Bypasses limits for premium users.
   */
  static async checkAndDecrementQuota(userId: string): Promise<void> {
    const user = await prisma.user.findUnique({
      where: { id: userId },
      include: { profile: { include: { aiUsage: true } } }
    });

    if (!user || !user.profile) throw new Error('User/Profile not found');

    // Premium bypass
    const isPremium = await this.isPremium(userId);
    if (isPremium) {
      logger.debug(`[AIQuota] User ${userId} is Premium. Bypassing limits.`);
      // We still update lifetime metrics for premium without failing
      await this.incrementUsage(user.profile.id);
      return;
    }

    let aiUsage = user.profile.aiUsage;
    const now = Clock.now();

    // If first time, create Usage record
    if (!aiUsage) {
      aiUsage = await prisma.aIUsage.create({
        data: {
          profileId: user.profile.id,
          resetAt: new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1),
        }
      });
    }

    // Reset daily if past resetAt
    if (now > aiUsage.resetAt) {
      aiUsage = await prisma.aIUsage.update({
        where: { id: aiUsage.id },
        data: {
          dailyUsed: 0,
          resetAt: new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1),
        }
      });
    }

    // Check Limits
    if (aiUsage.dailyUsed >= aiUsage.quotaDaily || aiUsage.monthlyUsed >= aiUsage.quotaMonthly) {
      throw ErrorFactory.create('AI004', 'Daily or Monthly AI Quota Exceeded. Please upgrade to Premium.');
    }

    // Decrement (Increment usage)
    await this.incrementUsage(user.profile.id);
  }

  private static async incrementUsage(profileId: string) {
    await prisma.aIUsage.update({
      where: { profileId },
      data: {
        dailyUsed: { increment: 1 },
        monthlyUsed: { increment: 1 },
        lifetimeUsed: { increment: 1 },
      }
    });
  }

  private static async isPremium(userId: string): Promise<boolean> {
    const activeSub = await prisma.subscription.findFirst({
      where: {
        userId,
        status: 'ACTIVE',
        expiresAt: { gt: Clock.now() }
      }
    });
    return !!activeSub;
  }
}
