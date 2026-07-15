/**
 * Sprint 14: Consistency Engine
 * Measures the variance in sleep and wake times. Vital metric for Wellness.
 */

export class ConsistencyEngine {
  
  /**
   * Returns a consistency score from 0-100 based on standard deviation of wake times.
   */
  static calculate(wakeTimes: number[]): number {
    if (wakeTimes.length < 3) return 50;

    const mean = wakeTimes.reduce((a, b) => a + b, 0) / wakeTimes.length;
    const variance = wakeTimes.reduce((a, b) => a + Math.pow(b - mean, 2), 0) / wakeTimes.length;
    const stdDevHours = Math.sqrt(variance);

    // If stdDev is 0 hours, score is 100. If stdDev is > 4 hours, score is near 0.
    const score = Math.max(0, 100 - (stdDevHours * 25));
    
    return Math.round(score);
  }
}
