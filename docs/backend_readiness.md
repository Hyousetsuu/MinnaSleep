# Backend Readiness Checklist (Sprint 6.5 Gate)

Dokumen ini adalah gerbang pamungkas sebelum satu baris kode pun ditulis di repositori Backend (Express.js) pada Sprint 7. Seluruh poin di bawah wajib dicentang hijau untuk menjamin pengembangan sinkron antara tim Flutter dan Backend.

## 📦 Domain & Data Integrity
- [ ] **DTO Stable**: Seluruh struktur payload JSON (Request/Response) telah disepakati dan dibekukan.
- [ ] **Entity Stable**: Skema entitas tidak akan berubah lagi tanpa persetujuan lintas tim.

## 🛡️ Reliability & Testing
- [ ] **Repository Contract Passed**: Semua repositori lokal Flutter telah melewati ujian kontrak.
- [ ] **Transaction Passed**: Tes *Stress* All-or-Nothing berhasil pada `TransactionManager`.
- [ ] **Offline Mode Passed**: Perilaku aplikasi tanpa koneksi internet sudah sempurna.
- [ ] **Sync Queue Tested**: Modul antrean (queue) terbukti tangguh secara lokal dan *race-condition free*.
- [ ] **Notification Pipeline Verified**: Proses pembuatan hingga pengiriman lokal bekerja mulus.

## 📜 API & Protocol Freezing
- [ ] **API Contract Frozen**: OpenAPI (`swagger.yaml`) telah diunggah dan tidak dapat direvisi secara sepihak.
- [ ] **Error Registry Frozen**: Seluruh *Error Code* (`AUTH_001`, `SYNC_001`, dsb) di `error_codes.md` bersifat statis.
- [ ] **Authentication Flow Approved**: Alur JWT, *Refresh Token*, dan pencabutan sesi (Revoke) telah dikunci.
- [ ] **Database Migration Policy**: Aturan migrasi (`upgrade`, `downgrade`, `seed`) dipahami dan disiapkan.
- [ ] **Feature Toggle Lifecycle**: Tahapan (*Experimental ➔ Internal ➔ Beta ➔ Public ➔ Deprecated*) diterapkan.

---
**Status Kesiapan Backend**: 🔴 BELUM SIAP
*(Eksekusi kode Express.js dilarang keras sebelum seluruh kotak dicentang).*
