import { prisma } from '../../../core/database/prisma.js';
import { User, Prisma } from '@prisma/client';

export class AuthRepository {
  static async findUserByEmail(email: string): Promise<User | null> {
    return prisma.user.findUnique({
      where: { email },
    });
  }

  static async createUser(data: Prisma.UserCreateInput): Promise<User> {
    return prisma.user.create({ data });
  }

  static async incrementFailedAttempts(userId: string): Promise<User> {
    return prisma.user.update({
      where: { id: userId },
      data: {
        failedLoginAttempts: { increment: 1 },
      },
    });
  }

  static async lockAccount(userId: string, lockedUntil: Date): Promise<void> {
    await prisma.user.update({
      where: { id: userId },
      data: {
        lockedUntil,
      },
    });
  }

  static async resetFailedAttempts(userId: string): Promise<void> {
    await prisma.user.update({
      where: { id: userId },
      data: {
        failedLoginAttempts: 0,
        lockedUntil: null,
      },
    });
  }
}
