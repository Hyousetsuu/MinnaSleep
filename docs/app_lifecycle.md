# App Lifecycle & Background Workers

## App Launch Flow
```mermaid
graph TD
    A[App Launch] --> B[Initialize Services]
    B --> C[Initialize DI]
    C --> D[Load Environment]
    D --> E[Restore Secure Session]
    E --> F[Open Drift Database]
    F --> G[Run Pending Sync Queue]
    G --> H[Load Dashboard]
```

## Background Worker Priorities
1. **Critical**: Sleep Worker
2. **High**: Notification Worker
3. **Medium**: Sync Worker
4. **Low**: Weekly Report
5. **Very Low**: Cleanup
