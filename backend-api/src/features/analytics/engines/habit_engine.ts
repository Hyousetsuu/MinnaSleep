/**
 * Sprint 14: Habit Analyzer
 * Context goldmine for the AI Sleep Coach. Detects specific behavioral patterns.
 */

export interface HabitAnalysis {
  weekendEffect: boolean;
  socialJetlag: boolean;
  sleepDrift: boolean;
}

export class HabitEngine {
  
  /**
   * Analyzes an array of daily sleep midpoints to detect lifestyle habits.
   */
  static analyze(weekdayMidpoints: number[], weekendMidpoints: number[]): HabitAnalysis {
    const avgWeekday = weekdayMidpoints.reduce((a, b) => a + b, 0) / (weekdayMidpoints.length || 1);
    const avgWeekend = weekendMidpoints.reduce((a, b) => a + b, 0) / (weekendMidpoints.length || 1);

    const shift = avgWeekend - avgWeekday;

    return {
      weekendEffect: shift > 1.5, // Sleeping 1.5 hours later on weekends
      socialJetlag: shift > 2.0,  // Severe shift indicative of social jetlag
      sleepDrift: false           // Requires rolling linear regression over weeks
    };
  }
}
