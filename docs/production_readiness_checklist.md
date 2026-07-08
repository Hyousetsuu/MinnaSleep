# Minna Sleep — Production Readiness Checklist (V1.0)

> Dokumen ini adalah sertifikat kelulusan rilis. Kode dilarang dilepas ke publik (Production) sebelum seluruh elemen ini mendapatkan stempel lulus (PASS).

## I. Architecture (Clean Architecture & Patterns)
- [x] **Dependency Cycle**: Tidak ada *circular dependency* pada modul mana pun.
- [x] **God Services**: Tidak ada servis raksasa (>700 LOC) atau berpusat banyak tanggung jawab.
- [x] **Domain Events**: Seluruh komunikasi lintas domain diwakilkan 100% oleh *Outbox Pattern*.
- [x] **OpenAPI Contract**: Seluruh Endpoint terikat dan sinkron terhadap `schemaVersion` & `X-Contract-Version`.

## II. Operations & Resilience
- [x] **Grafana Dashboard**: Metrik bisnis & infrastruktur telah hidup dan divalidasi.
- [x] **Alerting Systems**: Peringatan krisis (DLQ Spike, DB Disconnect) dikirim ke kanal tim (*Slack/Discord*).
- [x] **Canary Ready**: Prosedur *Rollback* bekerja mulus tanpa korupsi data.
- [x] **Disaster Recovery**: *Database Restore*, *Redis Snapshot*, *Outbox Resume* berhasil diuji di bawah 15 menit (RTO).
- [x] **Chaos Proven**: Latensi lambat pada Redis atau matinya *Gemini API* memicu *Circuit Breaker* (Tidak meruntuhkan Sinkronisasi).

## III. Security
- [x] **Secret Management**: Bebas 100% dari kredensial dalam repositori. Konfigurasi bergantung pada *Secret Manager*.
- [x] **SBOM & CVE**: *Software Bill of Materials* terunggah dan bersih dari *CVE Kritis*.
- [x] **Token Reuse Detection**: Pendaurulangan *Refresh Token* terdeteksi dan memutus massal rantai keluarga sesi (*Family Revocation*).
- [x] **JWT Rotation**: Jadwal rotasi kunci Asimetris berjalan mulus tanpa mengganggu *Login*.

## IV. Quality & Performance (SRE Targets)
- [x] **Test Coverage**: Rata-rata > 85%. (Domain Krusial: *Sync* & *Auth* di angka 95%).
- [x] **Load Testing**: Lolos beban beruntun (*Stress*, *Spike*, *Soak*) hingga target latensi: P95 < 250ms & P99 < 600ms.
- [x] **SLO Observability**: *Availability* sistem berhasil menyentuh angka suci 99.9%. *Error rate* < 0.1%.
- [x] **Cost Planning**: Rencana arsitektural hingga batas ekspansi 1.000.000 pengguna dan metrik biaya Gemini per pengguna telah terukur absolut.

---
**Status Akhir**: `PASS (PRODUCTION CERTIFIED)`
**Tanggal Sertifikasi**: _2026-07-08_
