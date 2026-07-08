import crypto from 'crypto';

export class IdGenerator {
  /**
   * Generates a UUID v4.
   * Centralizing this allows for predictable IDs during testing.
   */
  static generateUuid(): string {
    return crypto.randomUUID();
  }

  /**
   * Generates a cryptographically secure hex string.
   */
  static generateHex(bytes: number = 32): string {
    return crypto.randomBytes(bytes).toString('hex');
  }
}
