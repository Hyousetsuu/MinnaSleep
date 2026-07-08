import crypto from 'crypto';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const dir = path.join(__dirname, '../keys');
if (!fs.existsSync(dir)) fs.mkdirSync(dir);

// Generate ES256 (ECDSA using P-256 curve) key pair
const { publicKey, privateKey } = crypto.generateKeyPairSync('ec', {
  namedCurve: 'prime256v1',
  publicKeyEncoding: { type: 'spki', format: 'pem' },
  privateKeyEncoding: { type: 'pkcs8', format: 'pem' },
});

fs.writeFileSync(path.join(dir, 'public.pem'), publicKey);
fs.writeFileSync(path.join(dir, 'private.pem'), privateKey);
console.log('ES256 Keys generated successfully at /keys');
