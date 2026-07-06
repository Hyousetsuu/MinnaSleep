# Definition of Done (DoD) & Code Quality Metrics

Setiap Sprint atau Fitur baru dalam proyek Minna Sleep wajib memenuhi kriteria berikut sebelum ditandai sebagai selesai.

## 🛡️ Definition of Done
1. ✅ `flutter analyze` tidak memiliki error maupun warning.
2. ✅ Semua *Automated Tests* yang dibuat pada sprint bersangkutan (Widget/Golden/Integration/E2E) berjalan dan lulus.
3. ✅ Dokumentasi terkait (`docs/`) dan `CHANGELOG.md` telah diperbarui.
4. ✅ Tidak ada komentar `TODO`, `FIXME`, atau kode sisa (dead code) yang tertinggal di branch utama.
5. ✅ UI mematuhi **Neo Brutalism Design Checklist** secara mutlak.
6. ✅ Fungsionalitas berjalan sempurna baik di **Dark Theme** maupun **Light Theme** (tidak ada warna *hardcoded*).
7. ✅ *Accessibility* (A11y) dasar seperti area sentuh 48dp dan label pembaca layar terpenuhi.
8. ✅ Sejarah *commit* mengikuti standar **Conventional Commits** (`feat:`, `fix:`, `refactor:`, `docs:`).
9. ✅ Kode telah melalui *Pull Request Review* (jika dalam alur tim).

## 🚀 Performance Budget
Pengecekan performa harus dilakukan secara berkala.
- **Cold Start**: < 2 detik
- **Warm Start**: < 800 ms
- **Screen Transition**: < 300 ms
- **Frame Rate**: Stabil di 60–120 FPS
- **Database Query**: < 50 ms
- **Idle Memory**: < 200 MB
- **APK Size Limit**: < 60 MB
- **Background Battery Usage**: < 3% per jam

## 📏 Folder Size & Code Guidelines
- **Maximum File Length**: ±300 baris (untuk keterbacaan, pecah file jika lebih besar).
- **Maximum Widget Size**: ±200 baris.
- **Maximum Class Length**: ±500 baris.
- **Architecture Rule**: `UI` ➔ `Provider` ➔ `UseCase` ➔ `Repository` ➔ `Data Source`.
- UI tidak boleh melakukan import langsung ke model Drift atau DTO.
- Komunikasi lintas-fitur (`features/`) harus melalui `Repository` atau `UseCase`, dilarang mengimpor kelas internal fitur lain secara langsung.
