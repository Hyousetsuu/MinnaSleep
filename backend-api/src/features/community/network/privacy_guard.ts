/**
 * Sprint 15: Privacy Guard
 * The absolute gatekeeper for sharing sensitive sleep data.
 */

export enum PrivacyLevel {
  PUBLIC = 'PUBLIC',
  FRIENDS_ONLY = 'FRIENDS_ONLY',
  PRIVATE = 'PRIVATE'
}

export interface UserPrivacySettings {
  shareAchievements: PrivacyLevel;
  shareRawSleepData: PrivacyLevel;
  shareRecoveryScore: PrivacyLevel;
}

export class PrivacyGuard {
  
  /**
   * Evaluates if viewerId is permitted to see targetId's specific data type.
   */
  async canView(viewerId: string, targetId: string, dataLevel: PrivacyLevel, isMutualFriend: boolean): Promise<boolean> {
    if (viewerId === targetId) return true; // Can always see own data

    switch (dataLevel) {
      case PrivacyLevel.PUBLIC:
        return true;
      case PrivacyLevel.FRIENDS_ONLY:
        return isMutualFriend;
      case PrivacyLevel.PRIVATE:
        return false;
      default:
        return false;
    }
  }

  /**
   * By default, raw data (HRV, exact duration) is stripped out unless user opts in.
   */
  sanitizePayload(payload: any, isSharingRawDataAllowed: boolean): any {
    if (isSharingRawDataAllowed) return payload;

    // Strip sensitive metrics, keep only achievements and generic flags
    const { hrv, sleepDuration, exactBedTime, exactWakeTime, ...safePayload } = payload;
    return safePayload;
  }
}
