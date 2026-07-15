import { AIProvider } from '../providers/ai_provider.interface';

export class ProviderRegistry {
  private readonly _providers = new Map<string, AIProvider>();

  register(provider: AIProvider): void {
    const name = provider.metadata().provider;
    this._providers.set(name, provider);
  }

  get(name: string): AIProvider | undefined {
    return this._providers.get(name);
  }

  getAll(): AIProvider[] {
    return Array.from(this._providers.values());
  }
}
