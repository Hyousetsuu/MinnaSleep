import { OLAPRepository, AnalyticsSnapshotPayload } from '../repositories/olap_repository';

export class AnalyticsService {
  constructor(private olap: OLAPRepository) {}

  /**
   * Fast retrieval of the Daily Dashboard.
   * O(1) read latency because all metrics were pre-computed by the Snapshot Job.
   */
  async getDashboard(userId: string, date: string): Promise<AnalyticsSnapshotPayload> {
    const snapshot = await this.olap.getDailySnapshot(userId, date);
    if (!snapshot) {
      throw new Error(`ANA001: No analytics snapshot ready for date ${date}`);
    }
    return snapshot;
  }

  async getRecoveryTrends(userId: string, start: string, end: string) {
    const snapshots = await this.olap.getSnapshotRange(userId, start, end);
    return snapshots.map(s => ({ date: s.date, score: s.recoveryScore }));
  }
}
