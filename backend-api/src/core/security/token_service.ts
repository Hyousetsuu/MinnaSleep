import crypto from 'crypto';
import { PasswordService } from './password_service.js';

export class TokenService {
  /**
   * Generates a cryptographically secure random string for the Refresh Token.
   * @returns 64-character hex string (256-bit entropy)
   */
  static generateRefreshToken(): string {
    return crypto.randomBytes(32).toString('hex');
  }

  /**
   * Hashes the refresh token for safe storage in the database.
   * Using Argon2id as requested by security policy.
   * @param token The plaintext refresh token
   * @returns Hashed token
   */
  static async hashRefreshToken(token: string): Promise<string> {
    // We reuse the PasswordService which implements Argon2id
    return await PasswordService.hash(token);
  }

  /**
   * Verifies a provided refresh token against the stored hash.
   * @param hash Stored hash from UserSession
   * @param token Plaintext token provided by client
   * @returns boolean
   */
  static async verifyRefreshToken(hash: string, token: string): Promise<boolean> {
    return await PasswordService.verify(hash, token);
  }
}
