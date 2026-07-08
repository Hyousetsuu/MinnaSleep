import jwt from 'jsonwebtoken';
import fs from 'fs';
import path from 'path';
import { logger } from '../../logger.js';

export interface JwtPayload {
  sub: string; // userId
  sid: string; // sessionId
  role: string;
}

export class JwtService {
  private static privateKey: string;
  private static publicKey: string;

  static {
    try {
      const keysDir = path.resolve(process.cwd(), 'keys');
      JwtService.privateKey = fs.readFileSync(path.join(keysDir, 'private.pem'), 'utf8');
      JwtService.publicKey = fs.readFileSync(path.join(keysDir, 'public.pem'), 'utf8');
    } catch (error) {
      logger.error('Failed to load JWT Asymmetric Keys. Ensure keys/private.pem and keys/public.pem exist.', error);
      // Fallback for development if keys don't exist yet, but typically we should exit or crash
      // Leaving it to throw if used.
    }
  }

  /**
   * Signs a short-lived Access Token using ES256.
   * Expires in 15 minutes.
   */
  static signAccessToken(payload: JwtPayload): string {
    if (!this.privateKey) throw new Error('JWT Private Key not loaded');
    return jwt.sign(payload, this.privateKey, {
      algorithm: 'ES256',
      expiresIn: '15m',
      keyid: '2026-07', // Facilitates graceful key rotation without mass logout
    });
  }

  /**
   * Verifies an Access Token using ES256 Public Key.
   */
  static verifyAccessToken(token: string): JwtPayload {
    if (!this.publicKey) throw new Error('JWT Public Key not loaded');
    try {
      return jwt.verify(token, this.publicKey, { algorithms: ['ES256'] }) as JwtPayload;
    } catch (error) {
      throw new Error('Invalid or expired Access Token');
    }
  }
}
