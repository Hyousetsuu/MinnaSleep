# Feature Dependency Graph

Aturan baku untuk memastikan dependensi fitur di Minna Sleep bersifat **Satu Arah (Unidirectional)**. 
Modul tidak boleh saling bergantung (*circular dependency*).

```text
Dashboard
│
├── Sleep
├── Statistics
├── Notification
└── Profile

Profile
│
└── Statistics

Community
│
├── Profile
└── Notification

AI
│
├── Statistics
└── Sleep

Settings
│
├── Profile
└── Notification
```

## Aturan Emas
1. **DILARANG KERAS** `Statistics` mengimpor kelas dari `Profile`.
2. **DILARANG KERAS** `Sleep` mengimpor `Dashboard`.
3. Komunikasi mundur antar-fitur HANYA boleh menggunakan **Domain Events** (contoh: *SleepCompletedEvent* memicu *NotificationService*).
