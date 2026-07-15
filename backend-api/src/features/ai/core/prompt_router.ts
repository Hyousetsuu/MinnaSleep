import { ProviderRegistry } from './provider_registry';
import { AIProvider, AICapability } from '../providers/ai_provider.interface';

export enum RoutingPolicy {
  Cheapest,
  LowestLatency,
  HighestQuality,
  JsonOnly,
  Reasoning,
  Vision
}

export class PromptRouter {
  constructor(private registry: ProviderRegistry) {}

  /**
   * Selects the best provider based on the specified policy and capability requirements.
   */
  selectProvider(policy: RoutingPolicy, requiredCapability?: keyof AICapability): AIProvider {
    const providers = this.registry.getAll();
    if (providers.length === 0) {
      throw new Error('AI005: Provider Unavailable');
    }

    // Filter by capability if specified
    let candidates = requiredCapability 
      ? providers.filter(p => p.supports(requiredCapability))
      : providers;

    if (candidates.length === 0) {
       throw new Error(`AI006: No provider supports capability [${requiredCapability}]`);
    }

    switch (policy) {
      case RoutingPolicy.Cheapest:
        return candidates.sort((a, b) => a.metadata().costPerOutputToken - b.metadata().costPerOutputToken)[0];
      
      case RoutingPolicy.LowestLatency:
        return candidates.sort((a, b) => a.metadata().avgLatency - b.metadata().avgLatency)[0];
        
      case RoutingPolicy.HighestQuality:
        return candidates.sort((a, b) => a.metadata().priority - b.metadata().priority)[0];
        
      case RoutingPolicy.Reasoning:
        return candidates.filter(p => p.supports('reasoning'))
                         .sort((a, b) => a.metadata().priority - b.metadata().priority)[0] ?? candidates[0];
                         
      default:
        return candidates[0];
    }
  }

  /**
   * Automatic Failover: Called by AIGateway if the primary provider throws 429/Timeout.
   */
  getFallbackProvider(failedProviderName: string, policy: RoutingPolicy): AIProvider {
    const providers = this.registry.getAll().filter(p => p.metadata().provider !== failedProviderName);
    
    if (providers.length === 0) {
       throw new Error('AI005: All Providers Down. Failover exhausted.');
    }
    
    // Simplistic fallback: just return the highest priority remaining
    return providers.sort((a, b) => a.metadata().priority - b.metadata().priority)[0];
  }
}
