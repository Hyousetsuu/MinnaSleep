# Minna Sleep Architecture

## Core Principles
1. **Offline First**: All operations are written to the local Drift database first.
2. **Sync Queue**: Data modifications are queued and synced to the cloud in the background.
3. **Repository Pattern**: UI layers never talk to APIs directly, only to Repositories.
4. **Neo Brutalism**: UI follows strict Neo Brutalism design tokens (high contrast, bold typography, hard shadows).

## App Layers
- **UI (Presentation)**: Flutter Widgets, Riverpod State, and Theme Extension.
- **Domain (Core)**: Entities, Services (Logger, Network, Lifecycle).
- **Data (Repository)**: Drift DAO, Supabase API Client, Sync Worker.
