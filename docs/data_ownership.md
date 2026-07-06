# Data Ownership Rules

Satu Repository menguasai HANYA SATU Domain Entitas. Repository dilarang keras mengubah (Create/Update/Delete) data yang bukan miliknya.

## Matriks Kepemilikan Data

| Repository | Domain yang Dimiliki | Boleh Membaca | Dilarang Mengubah |
|------------|---------------------|---------------|-------------------|
| `SleepRepository` | `SleepSession` | - | `XP`, `Notification` |
| `ProfileRepository`| `ProfileEntity`, `Avatar` | `Settings` | `SleepSession`, `Settings` |
| `XPRepository` | `XP`, `Badge` | `Profile` | `SleepSession`, `Avatar` |
| `SettingsRepository`| `SettingsEntity` | `Profile` | `Profile`, `Badge` |
| `NotificationRepository`| `NotificationEntity` | `Settings` | `SleepSession`, `Profile` |

## Skenario Pelanggaran yang Dilarang
❌ `StartSleepUseCase` di `SleepRepository` memanggil `XPRepository.insertXp()`.
✅ `StartSleepUseCase` hanya menyimpan data tidur, lalu melempar `SleepCompletedEvent`. `XPService` mendengarkan event tersebut dan melakukan `insertXp()` melalui `XPRepository`.
