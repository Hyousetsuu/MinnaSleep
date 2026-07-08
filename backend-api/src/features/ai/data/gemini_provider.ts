import { AIProvider, AIRequestOptions } from '../domain/ai_provider.js';
import { AIInsightDTO, AIRecommendationDTO } from '../domain/ai_dto.js';
import { OutputValidator } from '../application/output_validator.js';
import { ErrorFactory } from '../../../core/api/error_factory.js';
import { logger } from '../../../logger.js';
// import { GoogleGenAI } from '@google/genai'; // Assuming this library exists in env

export class GeminiProvider implements AIProvider {
  // private ai: GoogleGenAI;

  constructor() {
    // Initialize Gemini SDK here
    // this.ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY });
  }

  getProviderName(): string {
    return 'gemini';
  }

  async generateInsight(prompt: string, options: AIRequestOptions): Promise<AIInsightDTO> {
    try {
      // Mock Gemini call
      // const response = await this.ai.models.generateContent({
      //   model: 'gemini-1.5-flash',
      //   contents: prompt,
      //   config: {
      //     responseMimeType: 'application/json',
      //     temperature: options.temperature ?? 0.7,
      //   }
      // });
      // const rawJson = response.text;

      // MOCK
      const rawJson = JSON.stringify({
        summary: 'Anda tidur cukup baik, namun durasinya masih kurang dari rekomendasi.',
        sleepScore: 78,
        factors: ['Durasi kurang', 'Jam tidur konsisten']
      });

      return OutputValidator.validateInsight(rawJson);
    } catch (e: any) {
      if (e.code && e.code.startsWith('AI')) throw e; // Pass through validator errors
      logger.error('[GeminiProvider] Timeout or Failure', e);
      throw ErrorFactory.create('AI002', 'Provider Timeout or Unavailable');
    }
  }

  async generateRecommendation(prompt: string, options: AIRequestOptions): Promise<AIRecommendationDTO> {
    try {
      // MOCK
      const rawJson = JSON.stringify({
        title: 'Tingkatkan Durasi',
        description: 'Cobalah tidur 30 menit lebih awal malam ini.',
        actionableSteps: ['Matikan lampu jam 10 malam', 'Hindari kafein setelah jam 2 siang'],
        priority: 'HIGH'
      });

      return OutputValidator.validateRecommendation(rawJson);
    } catch (e: any) {
      if (e.code && e.code.startsWith('AI')) throw e;
      throw ErrorFactory.create('AI002', 'Provider Timeout or Unavailable');
    }
  }
}
