/**
 * Sprint 12.5: AI Feature Flags
 * Resolves AI-specific runtime configurations dynamically via the ConfigService.
 * Prevents hardcoding behaviors, allowing graceful degradation without redeploys.
 */
import { ConfigService } from '../../core/config/config_service';

export class AIFeatureFlags {
  constructor(private configService: ConfigService) {}

  get isFallbackEnabled(): boolean {
    return this.configService.get('AI_ENABLE_FALLBACK') === 'true';
  }

  get isJudgeEnabled(): boolean {
    return this.configService.get('AI_ENABLE_JUDGE') === 'true';
  }

  get isStreamingEnabled(): boolean {
    return this.configService.get('AI_ENABLE_STREAMING') === 'true';
  }

  get isCachingEnabled(): boolean {
    return this.configService.get('AI_ENABLE_CACHING') === 'true';
  }
}
