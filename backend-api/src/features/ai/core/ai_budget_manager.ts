/**
 * Sprint 12.75: AI Budget Manager
 * Governs AI costs per user, per tenant, and globally to prevent overrun.
 */

export interface BudgetConfig {
  dailyLimit: number;
  monthlyLimit: number;
}

export class AIBudgetManager {
  
  /**
   * Evaluates if a user has enough budget to execute the prompt.
   */
  async checkUserBudget(userId: string, estimatedCost: number): Promise<boolean> {
    // 1. Fetch user's current spent amount from Redis/DB
    const currentDailySpent = await this._getDailySpent(userId);
    const limit = this._getUserDailyLimit();

    // 2. Validate
    if (currentDailySpent + estimatedCost > limit) {
      throw new Error(`AI012: User [${userId}] exceeded daily AI budget.`);
    }

    return true;
  }

  /**
   * Evaluates if a tenant (Hospital/Clinic) has enough budget.
   */
  async checkTenantBudget(tenantId: string, estimatedCost: number): Promise<boolean> {
    const currentMonthlySpent = await this._getMonthlySpent(tenantId);
    const limit = this._getTenantMonthlyLimit();

    if (currentMonthlySpent + estimatedCost > limit) {
      throw new Error(`AI013: Tenant [${tenantId}] exceeded monthly AI budget.`);
    }

    return true;
  }

  // --- Mocks ---
  private async _getDailySpent(userId: string): Promise<number> { return 0.50; }
  private _getUserDailyLimit(): number { return 1.00; } // $1.00 per day for normal users

  private async _getMonthlySpent(tenantId: string): Promise<number> { return 250.00; }
  private _getTenantMonthlyLimit(): number { return 500.00; } // $500 per month for clinics
}
