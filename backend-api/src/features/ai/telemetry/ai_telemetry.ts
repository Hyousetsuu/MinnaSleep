export enum AITelemetryEvent {
  AI_REQUEST_STARTED = 'AI_REQUEST_STARTED',
  AI_PROVIDER_SELECTED = 'AI_PROVIDER_SELECTED',
  AI_CACHE_HIT = 'AI_CACHE_HIT',
  AI_CACHE_MISS = 'AI_CACHE_MISS',
  AI_PROVIDER_FAILED = 'AI_PROVIDER_FAILED',
  AI_FALLBACK_USED = 'AI_FALLBACK_USED',
  AI_RESPONSE_VALIDATED = 'AI_RESPONSE_VALIDATED',
  AI_RESPONSE_BLOCKED = 'AI_RESPONSE_BLOCKED',
  AI_JUDGE_COMPLETED = 'AI_JUDGE_COMPLETED',
}

export interface TelemetryPayload {
  traceId: string;
  requestId: string;
  provider: string;
  model: string;
  latency?: number;
  tokens?: number;
  cost?: number;
  userTier?: string;
}

export class AITelemetry {
  
  /**
   * Logs structured JSON directly for Grafana/Loki consumption.
   */
  static logEvent(event: AITelemetryEvent, payload: TelemetryPayload) {
    const logEntry = {
      timestamp: new Date().toISOString(),
      event,
      ...payload
    };

    // In a real implementation, this pipes into Pino
    // logger.info(logEntry);
    console.log(JSON.stringify(logEntry));
  }
}
