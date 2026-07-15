/**
 * Sprint 17: Data Quality Scorer
 * Scores the completeness and reliability of a wearable session from 0 to 1.
 */

export class DataQualityScorer {
  
  score(data: any): number {
    let score = 1.0;
    
    // Penalize missing HRV
    if (!data.hrv) {
      score -= 0.3;
    }

    // Penalize low resolution sleep stages
    if (!data.sleepStages || !data.sleepStages.rem) {
      score -= 0.2;
    }

    // Ensure score stays bounded
    return Math.max(0, Math.min(score, 1.0));
  }
}
