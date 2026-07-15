import { PromptRouter, RoutingPolicy } from './prompt_router';
import { AIRequest, AIContext, AIResponse } from '../providers/ai_provider.interface';

/**
 * AI Control Plane Orchestrator (Phase 2).
 * Handles: Routing -> Provider -> Validator -> Guardrail -> Cache -> Response -> Queue(Judge)
 */
export class AIGateway {
  constructor(private router: PromptRouter) {}

  async generateInsight(request: AIRequest, context: AIContext, policy: RoutingPolicy): Promise<AIResponse> {
    // 1. Quota & Auth Checked prior to hitting this method in Controller

    // 2. Select Provider
    let provider = this.router.selectProvider(policy);
    
    // 3. Cache Check (Skipped in mock)
    // const cacheKey = generateHash(`${request.prompt}_${request.schemaVersion}_${provider.metadata().provider}_${request.promptVersion}`);
    // if (hit) return cachedResponse;

    try {
      // 4. Generate
      const response = await provider.generate(request, context);
      
      // 5. Guardrail Pipeline & JSON Validation (Phase 3)
      this._runGuardrailPipeline(response);

      // 6. BullMQ Asynchronous Judge Pipeline (Phase 4)
      this._dispatchJudgeJob(request, response, provider.metadata().provider);

      // 7. Telemetry & Analytics (Phase 5)
      this._emitTelemetry(provider.metadata().provider, response, false);

      return response;
      
    } catch (error: any) {
      // Automatic Failover Logic (Circuit Breaker / Rate Limit)
      if (error.statusCode === 429 || error.code === 'TIMEOUT') {
        const fallbackProvider = this.router.getFallbackProvider(provider.metadata().provider, policy);
        
        // Retry with Fallback
        const fallbackResponse = await fallbackProvider.generate(request, context);
        
        this._runGuardrailPipeline(fallbackResponse);
        this._dispatchJudgeJob(request, fallbackResponse, fallbackProvider.metadata().provider);
        this._emitTelemetry(fallbackProvider.metadata().provider, fallbackResponse, true);
        
        return fallbackResponse;
      }
      
      throw error;
    }
  }

  private _runGuardrailPipeline(response: AIResponse) {
    // Mock: Validates JSON, detects Medical Diagnosis, Unsafe advice
  }

  private _dispatchJudgeJob(request: AIRequest, response: AIResponse, providerName: string) {
    // Mock: BullMQ.add('judge-job', { request, response, providerName })
  }

  private _emitTelemetry(providerName: string, response: AIResponse, isFallback: boolean) {
    // Mock: Logs AI_PROVIDER_SELECTED, traceId, latency, tokens
  }
}
