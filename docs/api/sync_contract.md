# Sync Contract & Offline-First Policy

Dokumen ini membekukan strategi sinkronisasi data mutasi antara Drift (Flutter) dan Express.js (PostgreSQL).

## 1. Sync Lifecycle
1. **Client Action**: Data disimpan secara lokal di Drift. `SyncQueue` diisi dengan entri `PENDING`.
2. **Network Detect**: Jika online, `SyncCoordinator` menembak `POST /api/v1/sync`.
3. **Idempotency**: Semua request dikunci dengan header `Idempotency-Key` (e.g. `sync_req_123`).
4. **Resolution**: Express.js membandingkan data.
5. **Acknowledge**: Jika sukses, antrean lokal di-`DONE`-kan.

## 2. Optimistic Concurrency Control (OCC)
Setiap entitas yang dapat bermutasi (`Profile`, `Settings`, `Sleep`) wajib memiliki:
- `updatedAt` (ISO-8601 UTC)
- `version` (Integer, auto-increment setiap mutasi)

## 3. Conflict Resolution Matrix
Jika `local.version < remote.version`:
- **Sleep Session**: `Last Write Wins` (Timestamps).
- **Badge / Notification**: `Merge` (Gabungkan array IDs).
- **XP / Level**: `Recalculate` (Hitung ulang di backend, kirim hasil akhir ke client).
- **Settings**: `Cloud Overwrite` (Server menang).

## 4. Conflict Payload Structure (HTTP 409)
Jika Backend gagal melakukan *merge* otomatis, ia akan mengembalikan `409 Conflict`:
```json
{
  "error_code": "SYNC001",
  "conflict": {
    "entity": "sleep",
    "localVersion": 12,
    "remoteVersion": 15,
    "resolution": "last_write_wins",
    "serverState": { ... }
  }
}
```
Flutter wajib meng-override lokal dengan `serverState`.
