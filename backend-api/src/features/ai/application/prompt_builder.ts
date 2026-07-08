export interface SleepContext {
  durationMinutes: number;
  qualityScore?: number;
  bedTime: string;
  wakeTime: string;
}

export interface UserContext {
  ageGroup?: string;
  goals?: string[];
}

export class PromptBuilder {
  /**
   * Builds the prompt for generating a daily sleep insight.
   */
  static buildInsightPrompt(sleep: SleepContext, user?: UserContext): string {
    return `
You are an expert sleep coach. Analyze the following sleep data and provide a json insight.

Sleep Data:
- Duration: ${Math.floor(sleep.durationMinutes / 60)}h ${sleep.durationMinutes % 60}m
- Bedtime: ${sleep.bedTime}
- Wake Time: ${sleep.wakeTime}
- Self-reported Quality: ${sleep.qualityScore ?? 'Unknown'}/100

${user?.goals ? `User Goals: ${user.goals.join(', ')}` : ''}

Provide a JSON response adhering exactly to the requested schema. Do not include markdown formatting.
    `.trim();
  }

  /**
   * Builds the prompt for generating recommendations.
   */
  static buildRecommendationPrompt(recentSleeps: SleepContext[], user?: UserContext): string {
    const avgDuration = recentSleeps.reduce((sum, s) => sum + s.durationMinutes, 0) / (recentSleeps.length || 1);
    
    return `
You are an expert sleep coach. Based on the user's recent sleep average of ${Math.floor(avgDuration / 60)}h ${Math.round(avgDuration % 60)}m, provide 1 actionable recommendation.

${user?.goals ? `User Goals: ${user.goals.join(', ')}` : ''}

Provide a JSON response adhering exactly to the requested schema. Do not include markdown formatting.
    `.trim();
  }
}
