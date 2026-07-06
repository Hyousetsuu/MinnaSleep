# Production Readiness Gate (End of Sprint 4.3)

Dokumen ini adalah pos pemeriksaan mutlak sebelum aplikasi Minna Sleep beranjak ke fase optimasi (Sprint 5), monetisasi (Sprint 6), dan integrasi backend sesungguhnya (Sprint 7). Seluruh metrik dan audit di bawah ini *wajib* diselesaikan dan dicentang hijau.

## 🏛️ Architecture & Clean Code Audit
- [ ] **Layer Isolation**: Presentation tidak mengimpor Data. Domain tidak mengimpor Flutter UI.
- [ ] **Entity Purity**: Seluruh Entity bersifat Immutable.
- [ ] **DTO Containment**: DTO tidak pernah bocor melintasi batas Repository ke atas.
- [ ] **CQRS Integrity**: Write Repository terpisah dari Read Repository.
- [ ] **Dependency Graph**: Tidak ada *circular dependency*. Modul hanya berkomunikasi via kontrak *Domain*.

## 🏎️ Performance Regression Baseline
Target wajib vs Baseline aktual (Harus didokumentasikan):
- [ ] **Cold Start**: Target < 2.0s | Baseline: ___ s
- [ ] **Dashboard Render**: Target < 300ms | Baseline: ___ ms
- [ ] **Notification Center Render**: Target < 300ms | Baseline: ___ ms
- [ ] **Scroll FPS (1000 items)**: Target 60 FPS | Baseline: ___ FPS
- [ ] **Memory Peak**: Target < 200MB | Baseline: ___ MB

## 🛡️ Stability & Contract Tests
- [ ] **Repository Contract Test**: Lulus skenario ekstrem (*Cache Miss, Offline, Conflict, Rollback, Retry, Failure*).
- [ ] **Transaction Stress Test**: Simulasi *Insert* jamak yang gagal di tengah jalan wajib ter-*rollback* 100% tanpa sisa.
- [ ] **Background Worker Race Test**: TaskScheduler, SyncCoordinator, dan CleanupWorker berjalan simultan tanpa *deadlock* atau data ganda.

## 🧪 UI, Testing & Code Quality Assurance
- [ ] **Static Analysis**: Lulus `flutter analyze`, `dart format --set-exit-if-changed .`, dan `dart fix --dry-run`.
- [ ] **Coverage Gate**: Memenuhi target minimum pengujian (Domain ≥ 90%, Repository ≥ 80%, UseCase ≥ 90%, UI Widget ≥ 70%).
- [ ] **Widget & Golden Tests**: Seluruh komponen UI lolos tes interaksi (termasuk *Undo Delete*) dan render pixel-perfect.
- [ ] **Memory Leak Check**: Audit profil memori pasca *garbage collection* setelah siklus usap (swipe) notifikasi masif.
- [ ] **Accessibility Audit**: *Screen reader support*, *touch target size*, dan kontras warna terpenuhi.

## 🚀 Release & Deployment Verification
- [ ] **Dependency Freeze**: `pubspec.lock` dikunci. Dilarang menambah/update *package* kecuali perbaikan keamanan kritis.
- [ ] **Build Verification**: Sukses mengompilasi rilis nyata (`flutter build apk`, `appbundle`, dan `web`).
- [ ] **Release Smoke Test**: Manual QA sukses (Install ➔ Login ➔ Sleep ➔ Notif ➔ Profile ➔ Restart ➔ Offline ➔ Online ➔ Sync).
- [ ] **Documentation Completeness**: Setiap fitur memiliki README, diagram alur, dependensi, dan *future TODOs*.
- [ ] **CI/CD Ready**: Pipa rilis minimal berjalan otomatis (Push ➔ analyze ➔ test ➔ build_runner ➔ build ➔ artifact).

---
**Status Gerbang Produksi**: 🔴 TERTUTUP
*(Hanya akan berubah menjadi 🟢 TERBUKA setelah seluruh kotak di atas tercentang).*
