/**
 * Sprint 12.5: Versioned Prompt Registry
 * Maps prompts to specific versioned strings, allowing for Analytics correlation and A/B Testing.
 */

export interface PromptDefinition {
  key: string; // e.g., 'sleep_insight'
  version: number;
  template: string;
  isActive: boolean;
  changeReason?: string; // e.g. "v2: Reduced hallucination by forcing JSON schema"
}

export class PromptRegistry {
  private readonly _prompts = new Map<string, PromptDefinition[]>();

  register(prompt: PromptDefinition): void {
    if (!this._prompts.has(prompt.key)) {
      this._prompts.set(prompt.key, []);
    }
    this._prompts.get(prompt.key)!.push(prompt);
  }

  /**
   * Retrieves the active prompt version for a given key.
   */
  getActivePrompt(key: string): PromptDefinition {
    const versions = this._prompts.get(key);
    if (!versions || versions.length === 0) {
      throw new Error(`AI009: Prompt key [${key}] not found.`);
    }

    const active = versions.find(p => p.isActive);
    if (!active) {
      throw new Error(`AI010: No active prompt found for key [${key}].`);
    }

    return active;
  }
}
