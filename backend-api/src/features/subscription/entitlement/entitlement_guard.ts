/**
 * Sprint 18: Entitlement Guard Middleware
 * Combines Feature Flags and Entitlements with Dual Paywall Strategy.
 */

export class EntitlementGuard {
  
  /**
   * Tipe A: Soft Paywall
   * Endpoint still returns basic value, but locks deep insights.
   */
  async softPaywallGuard(userId: string, requiredEntitlement: string, basicData: any): Promise<any> {
    const userEntitlements = ['MANUAL_SLEEP', 'SOCIAL_FEED']; // Mock: Fetch from DB
    
    if (!userEntitlements.includes(requiredEntitlement)) {
      return {
        ...basicData,
        locked_insights: [requiredEntitlement]
      };
    }

    // User has access, return full data
    return {
      ...basicData,
      aiExplanation: "Insight mendalam dari AI Coach..."
    };
  }

  /**
   * Tipe B: Hard Barrier
   * Endpoint provides no value without subscription.
   */
  async hardBarrierGuard(userId: string, requiredEntitlement: string): Promise<any> {
    const userEntitlements = ['MANUAL_SLEEP', 'SOCIAL_FEED']; // Mock: Fetch from DB

    if (!userEntitlements.includes(requiredEntitlement)) {
      throw new Error(JSON.stringify({
        success: false,
        error: {
          code: "SUBSCRIPTION_REQUIRED",
          message: `Fitur ini tersedia untuk pengguna Minna Sleep Pro.`
        },
        paywall: {
          requiredEntitlement
        }
      }));
    }

    return true; // Proceed to controller
  }
}
