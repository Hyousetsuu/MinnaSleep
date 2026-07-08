# API Versioning & Deprecation Policy

Untuk menjaga stabilitas kontrak antara Flutter Client dan Express.js Backend, Minna Sleep mengadopsi kebijakan *Lifecycle* API yang ketat.

## 1. URI Versioning
Seluruh endpoint mutlak menggunakan awalan versi mayor:
`/api/v1/`

Tidak diperbolehkan membuat endpoint *root* (contoh: `/api/sync`). Versi harus eksplisit.

## 2. API Lifecycle
Setiap endpoint tunduk pada fase berikut:
1. **Active**: Endpoint direkomendasikan untuk digunakan (contoh: `/api/v1/sync`).
2. **Deprecated**: Endpoint masih beroperasi, namun klien Flutter diwajibkan bermigrasi ke versi baru (contoh: `/api/v2/sync`). Backend menyertakan header `Deprecation: true`.
3. **Sunset**: Endpoint dijadwalkan untuk dimatikan pada tanggal tertentu. Backend menyertakan header `Sunset: <HTTP-Date>`.
4. **Removed**: Endpoint dimatikan dan mengembalikan `410 Gone`.

## 3. Request Traceability (X-Request-ID)
Setiap pemanggilan dari Flutter wajib mengikutsertakan header `X-Request-ID` (contoh: `req_01J7V31M8A8KD6E`).
Kunci ini akan direkam melintasi:
`Flutter ➔ Express.js Logger ➔ Gemini API ➔ Database Audit Log`
Jika terjadi kesalahan (*crash* atau komplain pengguna), ID ini digunakan untuk melacak jejak secara spesifik tanpa bergantung pada urutan waktu log.
