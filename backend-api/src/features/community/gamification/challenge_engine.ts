/**
 * Sprint 15: Challenge Engine
 * Manages community-wide sleep challenges.
 */

export interface Challenge {
  id: string;
  name: string;
  description: string;
  type: 'CONSISTENCY' | 'TIMING' | 'DURATION';
  targetValue: number;
}

export class ChallengeEngine {
  
  private activeChallenges: Challenge[] = [
    { id: 'c1', name: '7-Day Consistency', description: 'Hit your sleep target 7 days in a row', type: 'CONSISTENCY', targetValue: 7 },
    { id: 'c2', name: 'Sleep Before 23:00', description: 'Go to bed before 11 PM', type: 'TIMING', targetValue: 23 },
    { id: 'c3', name: '8 Hours Challenge', description: 'Sleep for 8 full hours', type: 'DURATION', targetValue: 8 }
  ];

  async evaluateChallenges(userId: string, metrics: any): Promise<void> {
    // Evaluate if recent metrics satisfy active challenge conditions
    // If completed:
    console.log(`[ChallengeEngine] DomainEvent: ChallengeCompleted -> ${userId} completed '8 Hours Challenge'`);
  }

  getActiveChallenges(): Challenge[] {
    return this.activeChallenges;
  }
}
