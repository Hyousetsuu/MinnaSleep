# State Management Convention

Minna Sleep adheres to strict clean architecture state management rules using Riverpod.

## Flow
`Widget` ➔ `Riverpod Provider` ➔ `Repository (Interface)` ➔ `Local/Remote DataSource` ➔ `Drift / API`

## Rules
1. **NO Repository in Widget**: Widgets MUST NOT invoke Repositories or DAOs directly.
2. **Provider Only**: Widgets ONLY read and watch `Providers`.
3. **Logic in Repository**: All business logic, retry logic, and mapping exists in the Repository or Use Case layer.
4. **DTO to Entity**: Entity classes NEVER read JSON. `JSON ➔ DTO ➔ Mapper ➔ Entity`.

## Repository Naming Convention
- Interface: `AuthRepository`
- Implementation: `AuthRepositoryImpl`
- Data Sources: `LocalAuthRepository`, `RemoteAuthRepository`, `MockAuthRepository`
