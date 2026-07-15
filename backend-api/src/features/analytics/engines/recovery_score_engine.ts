/**
 * Sprint 14: Recovery Score Engine
 * Modular design allowing dynamic factors (SpO2, Body Temp) without changing the core engine.
 */

export interface RecoveryFactor {
  name: string;
  weight: number; // 0.0 - 1.0
  calculateScore(data: any): number; // Returns 0 - 100
}

export class HRVFactor implements RecoveryFactor {
  name = 'HRV';
  weight = 0.4;
  calculateScore(data: any): number { return Math.min(100, (data.hrv / 60) * 100); }
}

export class DeepSleepFactor implements RecoveryFactor {
  name = 'DeepSleep';
  weight = 0.35;
  calculateScore(data: any): number { return Math.min(100, (data.deepSleepMinutes / 120) * 100); }
}

export class RestingHRFactor implements RecoveryFactor {
  name = 'RestingHeartRate';
  weight = 0.25;
  calculateScore(data: any): number { return Math.max(0, 100 - (data.rhr - 40)); }
}

export class RecoveryScoreEngine {
  private _factors: RecoveryFactor[] = [];

  constructor() {
    // Register default factors
    this.registerFactor(new HRVFactor());
    this.registerFactor(new DeepSleepFactor());
    this.registerFactor(new RestingHRFactor());
  }

  registerFactor(factor: RecoveryFactor) {
    this._factors.push(factor);
    this._normalizeWeights();
  }

  private _normalizeWeights() {
    const totalWeight = this._factors.reduce((sum, f) => sum + f.weight, 0);
    this._factors.forEach(f => f.weight = f.weight / totalWeight);
  }

  calculate(healthData: any): number {
    let totalScore = 0;
    for (const factor of this._factors) {
      const score = factor.calculateScore(healthData);
      totalScore += score * factor.weight;
    }
    return Math.round(totalScore);
  }
}
