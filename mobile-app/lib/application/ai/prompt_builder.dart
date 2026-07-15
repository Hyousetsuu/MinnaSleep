import '../../domain/analytics/entities/health_summary.dart';

/// Phase 8: AI Integration (The Supreme Context)
/// Transforms the Unified Health Summary into a structured prompt for Gemini.
class HealthPromptBuilder {
  
  /// Builds the system prompt ensuring AI does not act as a doctor (Sprint 18 Rule)
  static String buildSystemConstraintPrompt() {
    return '''
You are Minna Sleep's AI Wellness Coach.
CRITICAL CONSTRAINT: You are a wellness and lifestyle assistant, NOT a medical doctor.
Do not provide medical diagnosis, treatment, or clinical advice.
If metrics indicate severe abnormalities (e.g., extremely low SpO2 or highly erratic HRV), 
advise the user to consult a healthcare professional.
Always frame insights as "wellness trends" or "potential correlations".
''';
  }

  /// Injects the Health Summary into the user's prompt context
  static String buildInsightPrompt(HealthSummary summary, String userQuery) {
    final contextData = summary.toJson();
    
    return '''
Based on the following unified health data from the user's wearables:

```json
$contextData
```

User's Question/Goal: "$userQuery"

Provide a personalized wellness insight analyzing the correlation between their sleep, cardiovascular, and activity metrics. Focus on recovery and lifestyle adjustments.
''';
  }
}
