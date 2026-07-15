/**
 * Sprint 15: Interaction Service
 * Provides lightweight interactions on timeline activities.
 */

export enum InteractionType {
  KUDOS = 'KUDOS',
  CHEER = 'CHEER',
  CELEBRATE = 'CELEBRATE'
}

export class InteractionService {
  
  async addInteraction(postId: string, userId: string, type: InteractionType): Promise<void> {
    // INSERT INTO interactions (postId, userId, type) VALUES ...
    console.log(`[Interaction] ${userId} gave ${type} to post ${postId}`);
  }

  async removeInteraction(postId: string, userId: string): Promise<void> {
    // DELETE FROM interactions WHERE ...
    console.log(`[Interaction] ${userId} removed interaction from post ${postId}`);
  }
}
