import { ModelDefinition } from './model_registry';

export interface CostEstimate {
  estimatedCost: number;
  actualCost: number | null;
  currency: string;
}

export class CostEngine {
  
  /**
   * Calculates the cost of a completed AI transaction.
   */
  static calculateCost(
    model: ModelDefinition, 
    inputTokens: number, 
    outputTokens: number
  ): CostEstimate {
    
    const inputCost = inputTokens * model.costPerInputToken;
    const outputCost = outputTokens * model.costPerOutputToken;
    const totalCost = inputCost + outputCost;

    return {
      estimatedCost: totalCost, // Pre-generation estimate if based on prompt length
      actualCost: totalCost,    // Post-generation exact billing
      currency: 'USD'
    };
  }

  /**
   * Checks if the user's quota or system budget permits the transaction.
   */
  static hasSufficientBudget(budgetRemaining: number, estimatedCost: number): boolean {
    return budgetRemaining >= estimatedCost;
  }
}
