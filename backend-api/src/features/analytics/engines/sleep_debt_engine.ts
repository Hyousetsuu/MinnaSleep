/**
 * Sprint 14: Sleep Debt Engine
 * Supports rolling time windows (e.g., 7d, 14d, 30d, 90d).
 */

export interface SleepSession {
  date: string;
  actualMinutes: number;
  targetMinutes: number;
}

export class SleepDebtEngine {
  
  /**
   * Calculates total sleep debt over a specific rolling window.
   * Positive = Debt (slept less than needed).
   * Negative = Surplus (slept more than needed).
   */
  static calculateDebt(sessions: SleepSession[], windowDays: number): number {
    // Sort descending by date, take top `windowDays`
    const sorted = [...sessions].sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());
    const targetSessions = sorted.slice(0, windowDays);

    let totalDebtMinutes = 0;

    for (const session of targetSessions) {
      const deficit = session.targetMinutes - session.actualMinutes;
      totalDebtMinutes += deficit;
    }

    return totalDebtMinutes;
  }
}
