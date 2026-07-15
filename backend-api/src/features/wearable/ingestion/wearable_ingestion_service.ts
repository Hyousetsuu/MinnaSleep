import { WearableValidator } from './wearable_validator.js';
import { WearableNormalizer } from './wearable_normalizer.js';

/**
 * Sprint 17: Wearable Ingestion Service
 * The main entry point for wearable data coming from the mobile app.
 */

export class WearableIngestionService {
  constructor(
    private validator: WearableValidator,
    private normalizer: WearableNormalizer
  ) {}

  async syncData(userId: string, wearableData: any[]): Promise<any> {
    let syncedCount = 0;
    for (const record of wearableData) {
      // 1. Log Source Traceability for Bug Hunting
      if (record.metadata) {
        console.log(`[Ingestion] Received from ${record.metadata.provider} (${record.metadata.deviceModel}) via ${record.metadata.syncMethod}`);
      }

      // 2. Validate physiological bounds
      if (this.validator.validate(record)) {
        
        // 3. Normalize timezones and units
        const normalized = this.normalizer.normalize(record);
        
        // 4. Note Capabilities
        if (normalized.capabilities && !normalized.capabilities.spo2) {
          console.log(`[Ingestion] Device lacks SpO2 capability. Skipping SpO2 gap analysis.`);
        }

        // Save `normalized` to Database
        syncedCount++;
      }
    }
    return { success: true, syncedCount };
  }
}
