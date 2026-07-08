# AI Foundation & Gemini Integration Contract

Karena keamanan API Key dan manajemen kuota, Flutter DILARANG menghubungi Gemini API secara langsung. Seluruh AI di-proxy melalui Express.js.

## 1. Provider Abstraction
Flutter mengandalkan antarmuka `AIRepository`. Saat ini diimplementasikan oleh `GeminiRemoteDataSource`, namun arsitekturnya terbuka untuk OpenAIRemoteDataSource jika diperlukan.

## 2. JSON Response Purity
Di level Backend, semua pemanggilan ke Gemini API **WAJIB** disuntikkan:
```json
"generationConfig": {
    "responseMimeType": "application/json"
}
```
Respons bebas (Markdown/teks biasa) dinyatakan cacat (`AI005`).

## 3. Rate Limit Contract
Backend mengatur Single Source of Truth untuk kuota gratis.
Setiap respons AI akan memuat HTTP Headers atau Body Meta:
```json
{
  "data": { ... },
  "usage": {
    "remainingRequests": 2,
    "resetAt": "2026-07-08T00:00:00Z"
  }
}
```

## 4. Schema & Prompt Versioning
Semua output JSON dari AI wajib dikawal dengan kunci `"schemaVersion"`, `"promptVersion"`, dan metadata analitik.
Contoh output sukses:
```json
{
  "schemaVersion": 1,
  "provider": "gemini",
  "promptVersion": 3,
  "model": "gemini-2.5-flash",
  "safety": "passed",
  "generatedAt": "2026-07-07T12:00:00Z",
  "summary": "Your REM sleep was phenomenal today.",
  "sleepScore": 88,
  "suggestions": [
    "Keep the room dark",
    "Maintain this schedule"
  ],
  "confidence": 0.95
}
```
Metadata ini memastikan jika kelak prompt berubah di Sprint 9, Flutter dapat melacak asal-usul insight tersebut untuk keperluan analitik dan *debugging*.

## 5. Main Isolate Processing
- Permintaan ke AI adalah murni pemanggilan Jaringan (*I/O Bound*).
- Oleh karena itu, antrean permintaan (*AI Queue*) **berjalan di Main Isolate** pada klien.
- *Background Isolate* (di Flutter) dilarang digunakan untuk menunggu respons API.
