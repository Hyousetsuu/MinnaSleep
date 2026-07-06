# Error Code Registry

Dokumen ini mendefinisikan kode error universal lintas platform (Flutter ↔ Express.js ↔ Supabase). Seluruh pelemparan pengecualian (*Exception/Failure*) wajib menggunakan referensi ID yang tercantum di bawah. Dilarang menggunakan string bebas/mentah.

## Authentication (AUTH_*)
| Code       | HTTP Status | Description                                      | Action Required by UI                 |
|------------|-------------|--------------------------------------------------|---------------------------------------|
| `AUTH_001` | 401         | Token expired atau invalid.                      | Logout dan arahkan ke layar Login.    |
| `AUTH_002` | 403         | Akses ditolak (Permission denied).               | Tampilkan SnackBar penolakan.         |
| `AUTH_003` | 400         | Kredensial tidak valid (Salah password/email).   | Tampilkan error inline pada form.     |

## Profile & Preferences (PROFILE_*)
| Code          | HTTP Status | Description                                      | Action Required by UI                 |
|---------------|-------------|--------------------------------------------------|---------------------------------------|
| `PROFILE_001` | 404         | Profil pengguna tidak ditemukan.                 | Sinkronisasi ulang atau buat baru.    |
| `PROFILE_002` | 400         | Format Avatar URL tidak didukung.                | Tampilkan toast peringatan.           |

## Synchronization (SYNC_*)
| Code       | HTTP Status | Description                                      | Action Required by UI                 |
|------------|-------------|--------------------------------------------------|---------------------------------------|
| `SYNC_001` | 409         | Sync Conflict (Server memiliki data lebih baru). | Rollback lokal dan jalankan resolusi. |
| `SYNC_002` | 503         | Server *down* saat sinkronisasi rutin.           | Beralih ke mode Offline mutlak.       |
| `SYNC_003` | 413         | Payload sinkronisasi terlalu besar.              | Pecah queue menjadi batch kecil.      |
| `SYNC_004` | 400         | Validasi integritas data gagal saat *upload*.    | Batalkan sinkronisasi spesifik item.  |

## Sleep Tracking (SLEEP_*)
| Code        | HTTP Status | Description                                      | Action Required by UI                 |
|-------------|-------------|--------------------------------------------------|---------------------------------------|
| `SLEEP_001` | 400         | Sesi tidur < 10 menit (Terlalu singkat).         | Abaikan sesi (tidak disimpan).        |
| `SLEEP_002` | 400         | Sesi tidur tumpang tindih (Overlap).             | Gabungkan dengan sesi sebelumnya.     |

> **Catatan**: Format kode error wajib diteruskan di dalam `Failure` class Flutter dan struktur JSON Response Express.js.
