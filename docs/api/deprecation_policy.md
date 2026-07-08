# API Deprecation Policy

Untuk menjamin kelancaran transisi arsitektur tanpa merusak *Client Application* (*Flutter* offline-first) yang mungkin masih berjalan dalam versi lawas, **Minna Sleep** menganut kebijakan Depresiasi (*Deprecation*) API yang ketat. 

Kebijakan ini menjamin tidak ada perubahan dadakan yang menyebabkan sistem gagal total pada tingkat *production*.

## 1. Fase API Lifecycle
Seluruh *Endpoint* di bawah payung Minna Sleep API diwajibkan melalui fase berikut secara berurutan:
1. **ACTIVE**: Fase penggunaan normal. API beroperasi penuh dengan tingkat layanan maksimal.
2. **DEPRECATED**: Klien baru tidak disarankan memakai endpoint ini. API ini tetap dijamin fungsinya selama **minimal 6 bulan** sejak pengumuman deprecation.
3. **SUNSET**: API akan dimatikan permanen pada tenggat waktu terpublikasi. Akses pada API mulai dijeda (seperti melempar limit secara ekstrem atau menyuntikkan *warning*) agar sisa pengguna *force-update*.
4. **REMOVED**: API telah tiada. Semua permintaan dibalas `410 Gone`.

## 2. Header Komunikasi Depresiasi
Saat fase *DEPRECATED* atau *SUNSET* aktif, *Backend* (Express.js) WAJIB menginjeksikan header berikut:
- `Deprecation: @<unix_timestamp>` (Memberi tahu waktu dimulainya deprecation)
- `Sunset: <HTTP-Date>` (Tanggal kematian mutlak API)
- `Link: <url-to-docs>; rel="deprecation"` (Tautan menuju dokumentasi migrasi v2)

## 3. Evaluasi Perubahan Kontrak (X-Contract-Version)
Kita menyadari sering kali URL `/api/v1` tetap dipertahankan, namun struktur objek JSON berevolusi.
Backend harus mengabarkan rilis spesifikasi DTO terbaru melalui *Header* standar perusahaan:
`X-Contract-Version: 2026-07`

Jika respons Backend menyertakan *Contract-Version* yang tidak didukung Flutter lokal, Flutter bertanggung jawab melakukan *downgrade mapping* atau memperingatkan pengguna.

## 4. Kebijakan Modifikasi Field (DTO)
- **TIDAK BOLEH** menghapus kolom secara diam-diam.
- **TIDAK BOLEH** mengubah tipe data (mis. *Integer* menjadi *String*) pada API yang sama.
- Apabila sebuah kolom harus dihapus, ia harus ditandai `@deprecated` pada OpenAPI, dan Backend tetap mengembalikan `null` atau nilai cadangan hingga fase *SUNSET* berakhir.

> **Sanksi Teknis**: Developer yang kedapatan menimpa `schema` API produksi tanpa mendirikan rute `/v2` atau melewati masa tenggang 6-bulan akan menyebabkan Pipeline CI/CD *Contract Test* gagal dan di-blok.
