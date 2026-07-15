/**
 * Sprint 16: Coach Session
 * Manages multi-turn conversations and context memory for the coaching chat.
 */

export interface ChatMessage {
  role: 'user' | 'coach';
  content: string;
  timestamp: string;
}

export class CoachSession {
  
  async getSessionHistory(sessionId: string): Promise<ChatMessage[]> {
    // In production, fetch from Redis or DB
    return [
      { role: 'user', content: 'Aku capek terus.', timestamp: '2026-07-15T12:00:00Z' },
      { role: 'coach', content: 'Mari kita lihat beberapa minggu terakhir.', timestamp: '2026-07-15T12:00:05Z' }
    ];
  }

  async appendMessage(sessionId: string, message: ChatMessage): Promise<void> {
    // Save to Redis or DB
    console.log(`[CoachSession] ${sessionId} appended message from ${message.role}`);
  }
}
