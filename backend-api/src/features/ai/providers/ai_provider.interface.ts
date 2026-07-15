export interface AICapability {
  vision: boolean;
  json: boolean;
  streaming: boolean;
  functionCalling: boolean;
  reasoning: boolean;
}

export interface ProviderMetadata {
  provider: string; // e.g., 'gemini', 'openai'
  model: string;    // e.g., 'gemini-2.5-pro'
  
  costPerInputToken: number;
  costPerOutputToken: number;
  
  avgLatency: number; // in milliseconds
  maxContext: number; // maximum token limit
  priority: number;   // 1 (highest) to N

  capabilities: AICapability;
}

export interface ProviderHealth {
  status: 'HEALTHY' | 'DEGRADED' | 'DOWN';
  latency: number;
  lastChecked: Date;
}

export interface AIRequest {
  prompt: string;
  schemaVersion: number;
  promptVersion: number;
  locale?: string;
}

export interface AIContext {
  healthSummary?: any; // The HealthSummary DTO from Sprint 11
  userProfile?: any;
}

export interface AIResponse {
  content: string; // The raw JSON string from the AI
  inputTokens: number;
  outputTokens: number;
}

export interface AIProvider {
  /**
   * Returns the metadata and capabilities of this provider.
   */
  metadata(): ProviderMetadata;

  /**
   * Generates the response based on the request and context.
   */
  generate(request: AIRequest, context: AIContext): Promise<AIResponse>;

  /**
   * Checks the health and latency of the provider's API.
   */
  health(): Promise<ProviderHealth>;

  /**
   * Checks if the provider supports a specific capability.
   */
  supports(capabilityKey: keyof AICapability): boolean;
}
