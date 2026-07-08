import { AIInsightDTO, AIRecommendationDTO } from './ai_dto.js';

export interface AIRequestOptions {
  userId: string;
  requestId: string;
  promptVersion: number;
  temperature?: number;
}

export interface AIProvider {
  /**
   * Generates a sleep insight based on the provided prompt context.
   */
  generateInsight(prompt: string, options: AIRequestOptions): Promise<AIInsightDTO>;

  /**
   * Generates actionable recommendations.
   */
  generateRecommendation(prompt: string, options: AIRequestOptions): Promise<AIRecommendationDTO>;
  
  /**
   * The name of the provider (e.g., 'Gemini', 'OpenAI').
   */
  getProviderName(): string;
}
