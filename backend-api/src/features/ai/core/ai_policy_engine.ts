/**
 * Sprint 12.75: AI Policy Engine
 * Maps user tiers to model capabilities dynamically, avoiding if-else scattering.
 */

export enum UserTier {
  FREE = 'FREE',
  PREMIUM = 'PREMIUM',
  ENTERPRISE = 'ENTERPRISE'
}

export interface AIPolicy {
  allowedModel: string;
  maxContextTokens: number;
}

export class AIPolicyEngine {
  
  /**
   * Resolves the AI policy based on the user's subscription tier.
   */
  static getPolicyForUser(tier: UserTier): AIPolicy {
    switch (tier) {
      case UserTier.FREE:
        return {
          allowedModel: 'gemini-2.5-flash',
          maxContextTokens: 3000,
        };
      case UserTier.PREMIUM:
        return {
          allowedModel: 'gemini-2.5-pro',
          maxContextTokens: 32000,
        };
      case UserTier.ENTERPRISE:
        return {
          allowedModel: 'claude-3-opus', // Reasoning capability
          maxContextTokens: 128000,
        };
      default:
        return {
          allowedModel: 'gemini-2.5-flash',
          maxContextTokens: 3000,
        };
    }
  }
}
