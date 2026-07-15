/**
 * Sprint 14: OLAP Repository Abstraction
 * Isolates the heavy analytical queries from the main PostgreSQL database.
 */

export interface AnalyticsSnapshotPayload {
  userId: string;
  date: string;
  recoveryScore: number;
  sleepDebt: number;
  chronotype: string;
  consistencyScore: number;
  trends: any;
}

export interface OLAPRepository {
  /**
   * Fast retrieval of a precomputed snapshot.
   */
  getDailySnapshot(userId: string, date: string): Promise<AnalyticsSnapshotPayload | null>;

  /**
   * Fast retrieval of a range of snapshots for trending graphs.
   */
  getSnapshotRange(userId: string, startDate: string, endDate: string): Promise<AnalyticsSnapshotPayload[]>;

  /**
   * Persists a newly computed snapshot into the OLAP store.
   */
  saveSnapshot(payload: AnalyticsSnapshotPayload): Promise<void>;
}

export class MockBigQueryRepository implements OLAPRepository {
  private _store = new Map<string, AnalyticsSnapshotPayload>();

  async getDailySnapshot(userId: string, date: string): Promise<AnalyticsSnapshotPayload | null> {
    const key = `${userId}_${date}`;
    return this._store.get(key) || null;
  }

  async getSnapshotRange(userId: string, startDate: string, endDate: string): Promise<AnalyticsSnapshotPayload[]> {
    // Mock implementation
    return Array.from(this._store.values()).filter(s => s.userId === userId && s.date >= startDate && s.date <= endDate);
  }

  async saveSnapshot(payload: AnalyticsSnapshotPayload): Promise<void> {
    const key = `${payload.userId}_${payload.date}`;
    this._store.set(key, payload);
  }
}
