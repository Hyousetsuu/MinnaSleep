import * as argon2 from 'argon2';
import { logger } from '../../logger.js';

export class PasswordService {
  /**
   * Hashes a plaintext password using Argon2id (OWASP recommended).
   * @param password Plaintext password
   * @returns Hashed password string
   */
  static async hash(password: string): Promise<string> {
    try {
      // Argon2id is the default algorithm in node-argon2
      return await argon2.hash(password, {
        type: argon2.argon2id,
        memoryCost: 2 ** 16, // 64 MB
        timeCost: 3,         // 3 iterations
        parallelism: 1,      // 1 thread
      });
    } catch (error) {
      logger.error('Error hashing password', error);
      throw new Error('Internal error during password hashing');
    }
  }

  /**
   * Verifies a plaintext password against an Argon2 hash.
   * @param hash Hashed password from database
   * @param password Plaintext password provided by user
   * @returns boolean indicating match
   */
  static async verify(hash: string, password: string): Promise<boolean> {
    try {
      return await argon2.verify(hash, password);
    } catch (error) {
      logger.error('Error verifying password', error);
      return false;
    }
  }
}
