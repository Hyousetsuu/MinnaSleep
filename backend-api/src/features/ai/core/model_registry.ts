/**
 * Sprint 12.5: Dynamic Model Registry
 * Decouples the generic AI Provider from specific model definitions.
 * Example: Provider 'gemini' can map to models 'gemini-2.5-flash', 'gemini-2.5-pro', etc.
 */

export interface ModelDefinition {
  id: string; // e.g. 'gemini-2.5-flash'
  providerId: string; // e.g. 'gemini'
  costPerInputToken: number;
  costPerOutputToken: number;
  maxContextTokens: number;
  tier: 'STANDARD' | 'PREMIUM' | 'RESEARCH';
}

export class ModelRegistry {
  private readonly _models = new Map<string, ModelDefinition>();

  register(model: ModelDefinition): void {
    this._models.set(model.id, model);
  }

  get(modelId: string): ModelDefinition | undefined {
    return this._models.get(modelId);
  }

  getModelsByProvider(providerId: string): ModelDefinition[] {
    return Array.from(this._models.values()).filter(m => m.providerId === providerId);
  }
}
