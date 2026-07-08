import { logger } from '../../logger.js';
import { EventEmitter } from 'events';

export interface AppConfig {
  features: {
    premiumRolloutPercentage: number;
    newAiModelRollout: number;
  };
  slo: {
    availabilityTarget: number;
    latencyP99Target: number;
  };
  region: string;
}

export class ConfigService extends EventEmitter {
  private configCache: AppConfig | null = null;
  private refreshInterval: NodeJS.Timeout | null = null;

  constructor() {
    super();
    // 1. Initial Load (Mocked from Distributed Config Store like Consul or Etcd)
    this.configCache = this.fetchFromDistributedStore();
  }

  public startRefreshCycle() {
    // 2. Refresh every 5 minutes
    this.refreshInterval = setInterval(() => {
      try {
        const newConfig = this.fetchFromDistributedStore();
        if (JSON.stringify(newConfig) !== JSON.stringify(this.configCache)) {
          this.configCache = newConfig;
          this.emit('configUpdated', newConfig);
          logger.info('[ConfigService] Configuration refreshed and updated.');
        }
      } catch (e) {
        logger.error('[ConfigService] Failed to refresh config', e);
      }
    }, 5 * 60 * 1000);
  }

  public getConfig(): AppConfig {
    if (!this.configCache) {
      throw new Error('Config not loaded yet');
    }
    return this.configCache;
  }

  /**
   * Evaluates if a feature is enabled for a specific user based on gradual rollout %.
   */
  public isFeatureEnabled(featurePercentage: number, userId: string): boolean {
    if (featurePercentage === 100) return true;
    if (featurePercentage === 0) return false;
    
    // Hash userId to get a stable number between 0 and 99
    const hash = userId.split('').reduce((acc, char) => acc + char.charCodeAt(0), 0);
    return (hash % 100) < featurePercentage;
  }

  private fetchFromDistributedStore(): AppConfig {
    // Stub for fetching from Remote Config Server
    return {
      features: {
        premiumRolloutPercentage: 100, // Phase 4: Feature Flag Rollout (1%, 10%, 100%)
        newAiModelRollout: 10,
      },
      slo: {
        availabilityTarget: 99.9, // Phase 3: SLO (99.9% Availability, Error Budget 0.1%)
        latencyP99Target: 600, // < 600ms
      },
      region: process.env.REGION || 'ap-southeast-1', // Phase 3: Multi-Region Support
    };
  }

  public stopRefreshCycle() {
    if (this.refreshInterval) clearInterval(this.refreshInterval);
  }
}

export const configService = new ConfigService();
