/**
 * Sprint 12.5: AI Decision Log
 * Logs the absolute orchestration path taken by the AI Gateway to resolve a request.
 */


export interface AIDecisionPayload {
  requestId: string;
  traceId: string;
  routingPolicy: string;
  selectedProvider: string;
  selectedModel: string;
  fallbackProvider: string | null;
  reason: string;
  decisionReason: string; // Sprint 12.75: Explainable Routing output
  cached: boolean;
  guardrailTriggered: boolean;
  judgeScore: number | null;
}

export class AIDecisionLogger {
  
  /**
   * Persists the decision map for deep debugging and failover analysis.
   */
  static logDecision(payload: AIDecisionPayload) {
    const logEntry = {
      timestamp: new Date().toISOString(),
      type: 'AI_DECISION_LOG',
      ...payload
    };

    // In production, this pipes to Pino or directly to the DB
    console.log(JSON.stringify(logEntry));
  }
}
