/**
 * Sprint 17: Wearable Validator
 * Ensures incoming data is within physiological boundaries.
 */

export class WearableValidator {
  
  validate(data: any): boolean {
    if (data.heartRate && data.heartRate.max > 300) {
      console.warn(`[WearableValidator] Rejected invalid HR: ${data.heartRate.max}`);
      return false;
    }
    if (data.spo2 && (data.spo2.average < 50 || data.spo2.average > 100)) {
      console.warn(`[WearableValidator] Rejected invalid SpO2: ${data.spo2.average}`);
      return false;
    }
    return true;
  }
}
