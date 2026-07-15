import { AIProvider, ProviderMetadata, ProviderHealth, AIRequest, AIContext, AIResponse, AICapability } from './ai_provider.interface';

export class GeminiProvider implements AIProvider {
  private readonly _metadata: ProviderMetadata = {
    provider: 'gemini',
    model: 'gemini-2.5-pro',
    costPerInputToken: 0.000125, // Mock pricing
    costPerOutputToken: 0.000375,
    avgLatency: 800,
    maxContext: 1000000,
    priority: 1,
    capabilities: {
      vision: true,
      json: true,
      streaming: false,
      functionCalling: true,
      reasoning: true,
    }
  };

  metadata(): ProviderMetadata {
    return this._metadata;
  }

  async generate(request: AIRequest, context: AIContext): Promise<AIResponse> {
    // 1. Mock connection to Gemini API
    // 2. Pass request.prompt + JSON.stringify(context.healthSummary)
    // 3. Await response
    
    return {
      content: JSON.stringify({
        recommendation: "Increase deep sleep by reducing caffeine intake after 2 PM.",
        schemaVersion: request.schemaVersion
      }),
      inputTokens: 350,
      outputTokens: 120,
    };
  }

  async health(): Promise<ProviderHealth> {
    return {
      status: 'HEALTHY',
      latency: 120, // ms
      lastChecked: new Date(),
    };
  }

  supports(capabilityKey: keyof AICapability): boolean {
    return this._metadata.capabilities[capabilityKey] === true;
  }
}
