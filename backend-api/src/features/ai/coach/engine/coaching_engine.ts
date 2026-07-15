import { UserContextBuilder } from '../context/user_context_builder';

/**
 * Sprint 16: Coaching Engine
 * The main brain. Orchestrates context, insights, explanations, and confidence.
 */

export interface CoachResponse {
  message: string;
  reason?: string;
  confidenceScore: number;
}

export class CoachingEngine {
  constructor(private contextBuilder: UserContextBuilder) {}

  async generateDailyInsight(userId: string): Promise<CoachResponse> {
    // Fetch context, evaluate via LLM Gateway...
    return {
      message: "Tidur 20 menit lebih awal malam ini.",
      reason: "Karena selama dua minggu terakhir kualitas pemulihanmu lebih baik ketika mulai tidur sebelum pukul 00:15.",
      confidenceScore: 0.94
    };
  }

  async generateMorningBrief(userId: string): Promise<CoachResponse> {
    return {
      message: "🎉 Recovery naik 12 poin. Hebat! Pertahankan pola tidur seperti minggu ini.",
      confidenceScore: 0.98
    };
  }

  async generateEveningPreparation(userId: string): Promise<CoachResponse> {
    return {
      message: "Biasanya kamu tidur jam 23.40. Agar target minggu ini tercapai, coba mulai bersiap sekitar 23.10.",
      confidenceScore: 0.88
    };
  }
}
