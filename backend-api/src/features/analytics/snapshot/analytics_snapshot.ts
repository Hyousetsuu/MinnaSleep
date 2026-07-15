import { OLAPRepository, AnalyticsSnapshotPayload } from '../repositories/olap_repository';
import { RecoveryScoreEngine } from '../engines/recovery_score_engine';
import { SleepDebtEngine } from '../engines/sleep_debt_engine';
import { ChronotypeEngine } from '../engines/chronotype_engine';
import { ConsistencyEngine } from '../engines/consistency_engine';

/**
 * Sprint 14: Analytics Snapshot
 * Background job that pre-computes the heavy analytics and stores them in OLAP.
 * Ensures the API reads dashboard data in <100ms.
 */
export class AnalyticsSnapshotJob {
  constructor(
    private olap: OLAPRepository,
    private recoveryEngine: RecoveryScoreEngine
  ) {}

  async computeAndStoreDailySnapshot(userId: string, date: string, rawData: any) {
    console.log(`[Snapshot] Computing Daily Analytics for user ${userId} on ${date}`);

    const recoveryScore = this.recoveryEngine.calculate(rawData);
    
    // Using default/mock inputs for demonstration
    const sleepDebt = SleepDebtEngine.calculateDebt(rawData.sessions || [], 14);
    const chronotypeResult = ChronotypeEngine.analyze(rawData.midpoints || []);
    const consistencyScore = ConsistencyEngine.calculate(rawData.wakeTimes || []);

    const payload: AnalyticsSnapshotPayload = {
      userId,
      date,
      recoveryScore,
      sleepDebt,
      chronotype: chronotypeResult.type,
      consistencyScore,
      trends: {} // Could be injected from TrendEngine
    };

    await this.olap.saveSnapshot(payload);
    console.log(`[Snapshot] Saved. Recovery: ${recoveryScore}, Debt: ${sleepDebt}m`);
  }
}
