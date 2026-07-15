import { AIResponse, AIRequest } from '../providers/ai_provider.interface';

export interface JudgeScores {
  safetyScore: number;
  medicalScore: number;
  toneScore: number;
  qualityScore: number;
  overallScore: number;
}

export class JudgeWorker {
  
  /**
   * Called asynchronously by BullMQ. Does not block the HTTP Response.
   */
  async processJob(jobData: { request: AIRequest, response: AIResponse, provider: string }) {
    const { request, response, provider } = jobData;

    // 1. Run Judges in parallel
    const [safety, medical, tone, quality] = await Promise.all([
      this._runSafetyJudge(response),
      this._runMedicalJudge(response),
      this._runToneJudge(response),
      this._runQualityJudge(response),
    ]);

    const overall = (safety + medical + tone + quality) / 4.0;

    const scores: JudgeScores = {
      safetyScore: safety,
      medicalScore: medical,
      toneScore: tone,
      qualityScore: quality,
      overallScore: overall
    };

    // 2. Persist to PromptAnalytics Database (Prisma)
    await this._savePromptAnalytics({
      provider,
      inputTokens: response.inputTokens,
      outputTokens: response.outputTokens,
      promptVersion: request.promptVersion,
      schemaVersion: request.schemaVersion,
      scores
    });
  }

  // --- Mock Judges ---
  private async _runSafetyJudge(response: AIResponse): Promise<number> { return 1.0; } // Checks toxic, unsafe
  private async _runMedicalJudge(response: AIResponse): Promise<number> { return 0.95; } // Checks diagnosis, prescription
  private async _runToneJudge(response: AIResponse): Promise<number> { return 0.98; } // Checks empathy, clarity
  private async _runQualityJudge(response: AIResponse): Promise<number> { return 0.94; } // Checks JSON validity, groundedness

  private async _savePromptAnalytics(data: any) {
    // Prisma.promptAnalytics.create(...)
  }
}
