/**
 * Sprint 14: Trend Engine
 * Comparative calculator for directional analytics (+X% or -Y%).
 */

export interface TrendResult {
  currentValue: number;
  previousValue: number;
  percentageChange: number;
  direction: 'UP' | 'DOWN' | 'FLAT';
}

export class TrendEngine {
  
  static calculate(current: number, previous: number): TrendResult {
    if (previous === 0) return { currentValue: current, previousValue: previous, percentageChange: 0, direction: 'FLAT' };

    const diff = current - previous;
    const percentage = (diff / previous) * 100;
    
    let direction: 'UP' | 'DOWN' | 'FLAT' = 'FLAT';
    if (diff > 0) direction = 'UP';
    if (diff < 0) direction = 'DOWN';

    return {
      currentValue: current,
      previousValue: previous,
      percentageChange: Number(percentage.toFixed(2)),
      direction
    };
  }
}
