# Production Release Checklist (Sprint 10)

Dokumen ini mengawal peluncuran fisik (Deployment) ke Google Play Store / Apple App Store. Kualitas *engineering* bukan satu-satunya syarat; kesiapan bisnis dan pemantauan juga wajib dipenuhi.

## 🛠️ Code & Build Checks
- [ ] **Version Bump**: `pubspec.yaml` diperbarui ke versi rilis final (misal: `1.0.0`).
- [ ] **API Compatibility**: Build aplikasi terhubung ke Environment *Production* (bukan Staging) dengan kompatibilitas API sukses (v1).
- [ ] **Migration Tested**: Skema basis data baru terbukti sukses di-*upgrade* dari instalasi versi lama.
- [ ] **Crash Free**: Laporan *Crash* pada *release build test* 0%.

## 📡 Observability & Configurations
- [ ] **Analytics Enabled**: Perekaman metrik Firebase / PostHog diaktifkan.
- [ ] **Telemetry Active**: `TelemetryProvider` (Crash/Metrics/Tracing) aktif melapor ke dasbor *Production*.
- [ ] **Remote Config Updated**: Nilai-nilai konfigurasi dinamis jarak jauh divalidasi kebenarannya.
- [ ] **Feature Flags Checked**: Fitur *Experimental* atau *Beta* dinonaktifkan secara *default* untuk audiens publik.

## 📄 Documentation & Assets
- [ ] **CHANGELOG.md**: Diperbarui dengan deskripsi bahasa awam untuk pengguna (Release Notes).
- [ ] **App Store Assets**: Tangkapan layar (*Screenshots*), teks deskripsi, dan ikon rilis final dikunci.
