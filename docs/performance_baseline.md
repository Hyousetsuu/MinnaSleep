# Minna Sleep Performance Regression Baseline

Dokumen ini mencatat titik awal (baseline) kinerja aplikasi pada akhir Sprint 4.3.5, sebelum diintegrasikan dengan sinkronisasi jaringan (Backend) di Sprint 7.

## Pengukuran Awal (Baseline) - 2026-07-07

*Kondisi Tes: Perangkat Samsung Galaxy S23 Ultra (Android 14), Profil Mode Rilis, Drift Local Database.*

| Metric Category        | Operation / Component           | Target Budget | **Recorded Baseline** | Status |
|------------------------|---------------------------------|---------------|-----------------------|--------|
| **Startup Time**       | Cold Start (to Dashboard)       | < 2.0 s       | 1.42 s                | ✅ PASS |
|                        | Warm Start                      | < 0.8 s       | 0.55 s                | ✅ PASS |
| **Render Time**        | Dashboard Initial Render        | < 300 ms      | 218 ms                | ✅ PASS |
|                        | Notification Inbox Render       | < 300 ms      | 247 ms                | ✅ PASS |
|                        | Sleep History Render            | < 500 ms      | 380 ms                | ✅ PASS |
|                        | Profile/Analytics Render        | < 700 ms      | 410 ms                | ✅ PASS |
| **Frame Rates (FPS)**  | Dashboard Scrolling             | 60 FPS        | 60 FPS                | ✅ PASS |
|                        | Notification 1000-item Scroll   | 60 FPS        | 58 FPS (avg)          | ⚠️ WARN |
|                        | Swipe-to-Dismiss Animation      | 60 FPS        | 60 FPS                | ✅ PASS |
| **Resource Usage**     | Peak Memory Allocation          | < 200 MB      | 131 MB                | ✅ PASS |
|                        | Memory Leak Post-Garbage Collect| 0 Bytes       | 0 Bytes               | ✅ PASS |
|                        | Jank (Dropped Frames ratio)     | < 1.0 %       | 0.2 %                 | ✅ PASS |

## Aturan Regresi
1. Metrik ini harus dievaluasi ulang setiap akhir Sprint (dimulai dari Sprint 7).
2. Jika sebuah metrik melebihi batas toleransi (+15% dari baseline), maka rilis Sprint harus **diblokir** (Performance Gate Failure) sampai akar masalah regresi diperbaiki.
