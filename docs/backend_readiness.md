# Backend Readiness Checklist (Sprint 6.5 Quality Gate)

Express.js TIDAK BOLEH ditulis sebelum daftar ini seluruhnya dicentang (Hukum *Contract-First*).

- [x] **OpenAPI Specification**: `docs/api/openapi.yaml` selesai dan divalidasi linter.
- [x] **DTO Freeze**: Struktur objek JSON dibekukan dalam skema OpenAPI.
- [x] **Error Registry**: Seluruh kode `AUTH`, `SYNC`, dan `AI` terdaftar di `docs/api/error_registry.md`.
- [x] **Auth Contract**: Siklus Access/Refresh token terdokumentasi.
- [x] **Sync Contract**: Aturan resolusi konflik dan antrean di `sync_contract.md`.
- [x] **API Versioning**: Prefix `/api/v1/` dipatok secara absolut.
- [x] **Idempotency**: Spesifikasi `Idempotency-Key` diwajibkan untuk endpoint mutasi.
- [x] **Pagination**: Ditetapkan menggunakan `cursor`-based pagination untuk kapabilitas offline-first.
- [x] **Isolate Constraints**: Dokumentasi batasan *Main Isolate* vs *Background Isolate* untuk klien.
- [x] **API Compatibility Fixtures**: JSON Dummy untuk *Contract Tests* tersedia di `test/contracts/fixtures/`.
