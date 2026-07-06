# Accessibility Audit (Neo Brutalism Design)

Dokumen ini merekam hasil audit kesesuaian aksesibilitas antarmuka pengguna Minna Sleep terhadap standar WCAG 2.1 AA/AAA. Karena gaya Neo Brutalism bergantung pada kontras ekstrem dan tata letak padat, pengujian ini berfungsi sebagai gerbang rilis (Sprint 4.4).

## 🎨 1. Contrast Check (WCAG AA/AAA)
Gaya desain Neo Brutalism (Teks dan batas gelap di atas warna cerah) diverifikasi terhadap rasio minimal.
- [x] **Normal Text vs Background** (Target: ≥ 4.5:1)
- [x] **Large Text vs Background** (Target: ≥ 3.0:1)
- [x] **Icon vs Background** (Target: ≥ 3.0:1)
- [x] **Border Visibility** (Solid black borders aman di mode Light, diverifikasi terlihat jelas di mode Dark).

## 👆 2. Touch Target Size
- [x] Semua tombol kustom (`NeoButton`, `NeoAnimatedFAB`, `NotificationTile`) memenuhi area sentuh minimal `48x48 dp`.

## 🗣️ 3. Screen Reader (TalkBack / VoiceOver)
- [x] **Semantics**: Komponen interaktif memiliki `Semantics(button: true, label: "...", hint: "...")`.
- [x] **ExcludeSemantics**: Semua ornamen, bayangan, dan dekorasi diabaikan dari bacaan.
- [x] **Loading States**: `LoadingSkeleton` dibaca dengan baik (contoh: *"Loading content"*), bukan dipecah per kotak.
- [x] **MergeSemantics**: `NotificationTile` dan kartu dibaca sebagai satu kesatuan konteks (contoh: *"Sleep completed. 7 hours 30 minutes. Unread."*).

## 🔀 4. Focus & Navigation
- [x] **Focus Order**: Menggunakan `FocusTraversalGroup` untuk urutan masuk akal pada form dan pengaturan.
- [x] **Keyboard Navigation**: Status *Focus* terlihat jelas bagi pengguna D-Pad/Keyboard eksternal.

## 🔠 5. Dynamic Text Scaling
- [x] Layar utama lolos uji skala `2.0x` tanpa *RenderFlex Overflow*.
- [x] Clamp (`MediaQuery.withClampedTextScaling`) hanya diaplikasikan pada kotak berukuran mutlak (fixed-size components) dengan maksimum `2.0x`.
