# Minna Sleep Error Registry

Seluruh kesalahan yang ditangkap oleh Flutter atau dilempar oleh Express.js WAJIB dipetakan ke dalam salah satu kode di bawah ini.

## Authentication (AUTH)
| Code | Message | Description |
|---|---|---|
| `AUTH001` | Invalid credentials | Login gagal akibat kredensial salah |
| `AUTH002` | Expired token | JWT kedaluwarsa, butuh refresh |
| `AUTH003` | Unauthorized | Akses endpoint ditolak |

## Profile (PROFILE)
| Code | Message | Description |
|---|---|---|
| `PROFILE001` | Username already exists | Klaim username gagal karena duplikasi |

## Sync & Concurrency (SYNC)
| Code | Message | Description |
|---|---|---|
| `SYNC001` | Conflict detected | `localVersion` tertinggal dari `remoteVersion` |
| `SYNC002` | Retry required | Sinkronisasi terputus, retry dengan Idempotency Key sama |

## Notification (NOTIFICATION)
| Code | Message | Description |
|---|---|---|
| `NOTIFICATION001` | Notification expired | Notifikasi sudah kadaluarsa sebelum dibaca |

## System (SYSTEM)
| Code | Message | Description |
|---|---|---|
| `SYSTEM001` | Internal server error | Kesalahan tak tertangani di Express.js |

## Artificial Intelligence (AI)
| Code | Message | Description |
|---|---|---|
| `AI001` | Prompt validation failed | Format input Flutter ditolak |
| `AI002` | Rate limit exceeded | Melampaui batas laju dari Provider Gemini API |
| `AI003` | Provider timeout | Gemini API gagal merespons dalam 15s |
| `AI004` | Provider unavailable | Gemini API sedang *downtime* |
| `AI005` | Invalid AI response | Respons AI tidak dapat diparsing (Bukan JSON) |
| `AI006` | Safety filter triggered | Prompt ditolak oleh *Safety Settings* Gemini |
| `AI007` | Quota exceeded | Pengguna *Free* melampaui batas harian (5x) |
| `AI008` | Malformed JSON response | AI merespons JSON, tapi struktur cacat |
