/**
 * Sprint 15: Personality Formatter
 * Formats timeline events with various tones to make the feed feel alive and entertaining,
 * rather than just a dry statistical read.
 */

export enum PersonalityTone {
  CHILL = 'CHILL',
  FUNNY = 'FUNNY',
  CUTE = 'CUTE',
  MINIMAL = 'MINIMAL',
  ANIME = 'ANIME'
}

export interface FormattedEvent {
  message: string;
  badgeIcon?: string;
  badgeLabel?: string;
  isPrivacyShared?: boolean;
}

export class PersonalityFormatter {
  
  static formatSleepDuration(userName: string, hours: number, tone: PersonalityTone, isSharedExplicitly: boolean): FormattedEvent {
    let message = '';
    switch (tone) {
      case PersonalityTone.FUNNY:
        message = `😴 ${userName} menghilang selama ${hours} jam.`;
        break;
      case PersonalityTone.CUTE:
        message = `🦥 ${userName} sedang mengejar gelar Koala Kehormatan dengan tidur ${hours} jam!`;
        break;
      case PersonalityTone.ANIME:
        message = `🔥 Nani?! ${userName} memulihkan chakra selama ${hours} jam berturut-turut!`;
        break;
      default:
        message = `🌙 ${userName} menyelesaikan sesi tidur (${hours}h).`;
        break;
    }

    return {
      message,
      isPrivacyShared: isSharedExplicitly // Flutter UI will render "Shared by user" label based on this
    };
  }

  static formatStreak(userName: string, days: number, tone: PersonalityTone): FormattedEvent {
    return {
      message: `⭐ ${userName} baru saja mencapai ${days}-Day Sleep Streak!`,
      badgeIcon: '🏆',
      badgeLabel: `${days}-Day Streak`
    };
  }
}
