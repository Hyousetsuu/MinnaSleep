/**
 * Sprint 14: Chronotype Engine
 * Classifies sleep patterns with a confidence score to reflect biological reality.
 */

export interface ChronotypeResult {
  type: 'Lion' | 'Bear' | 'Wolf' | 'Dolphin';
  confidence: number; // 0.0 - 1.0
}

export class ChronotypeEngine {
  
  /**
   * Analyzes an array of sleep midpoint times (in hours past midnight) to determine chronotype.
   */
  static analyze(midpoints: number[]): ChronotypeResult {
    if (midpoints.length === 0) return { type: 'Bear', confidence: 0.1 };

    const avgMidpoint = midpoints.reduce((a, b) => a + b, 0) / midpoints.length;
    
    // Variance calculates consistency. Lower variance = higher confidence.
    const variance = midpoints.reduce((a, b) => a + Math.pow(b - avgMidpoint, 2), 0) / midpoints.length;
    const confidence = Math.max(0.1, 1.0 - (variance / 10));

    if (avgMidpoint < 2.5) return { type: 'Lion', confidence };
    if (avgMidpoint >= 2.5 && avgMidpoint < 4.5) return { type: 'Bear', confidence };
    return { type: 'Wolf', confidence };
    // Dolphin requires analyzing fragmentation, simplified here.
  }
}
