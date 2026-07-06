# API Version Contract

Dokumen ini mendefinisikan standar teknis komunikasi API antara Flutter Client dan Express.js Server. Seluruh endpoint **WAJIB** mematuhi pedoman ini.

## 1. Request Protocol
- **Format**: JSON (`application/json`).
- **Base URL**: `/api/v1/`.
- **Method Standards**:
  - `GET`: Mengambil data (Tidak merubah state).
  - `POST`: Membuat entitas baru (Tidak idempoten).
  - `PUT`: Memperbarui keseluruhan entitas (Idempoten).
  - `PATCH`: Memperbarui sebagian entitas (Idempoten).
  - `DELETE`: Menghapus entitas (Idempoten).

## 2. Response Structure
Semua respons server dibungkus dalam format standar:
```json
{
  "success": true,
  "data": { ... }, // Payload, null jika error
  "meta": { ... }, // Pagination, Cursor, dll (opsional)
  "error": null // Object Error jika success: false
}
```

## 3. Error Structure
```json
{
  "success": false,
  "data": null,
  "error": {
    "code": "SYNC_001", // Merujuk pada error_codes.md
    "message": "Data conflict detected",
    "details": ["updated_at is older than server"] // Opsional
  }
}
```

## 4. Observability (Correlation ID)
- Setiap *request* dari Flutter wajib menyertakan Header: `X-Request-Id: <UUID>`.
- Server Express.js akan mencatat ID ini di sistem Log dan meneruskannya ke Supabase.
- Sangat mempermudah *debugging* pelacakan *end-to-end*.

## 5. Pagination & Cursors
Dilarang menggunakan kombinasi Limit/Offset sederhana untuk data yang sering bermutasi.
Gunakan format kursor:
```json
// Request
GET /api/v1/notifications?limit=20&lastId=ntf_123&lastCreatedAt=2026-07-07T00:00:00Z

// Meta Response
"meta": {
  "hasMore": true,
  "nextCursor": {
    "lastId": "ntf_143",
    "lastCreatedAt": "2026-07-06T23:00:00Z"
  }
}
```

## 6. Authentication & Headers
- **Authorization**: `Bearer <Supabase_JWT>`.
- **Client-Version**: `v1.2.0` (Mencegah versi usang mengakses API baru).
- **Timezone**: `Asia/Jakarta` atau *Offset* (Membantu komputasi backend).

## 7. Idempotency
Semua operasi kritis (terutama Sync, Payment, dan Badge Unlocking) wajib menyertakan `Idempotency-Key` di *Header* untuk mencegah eksekusi ganda jika terjadi *Retry* otomatis akibat koneksi terputus.
