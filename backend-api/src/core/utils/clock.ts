export class Clock {
  /**
   * Returns the current date and time.
   * Centralizing this allows for easy mocking in unit tests (time travel).
   */
  static now(): Date {
    return new Date();
  }

  /**
   * Returns the current timestamp in milliseconds.
   */
  static nowMs(): number {
    return Date.now();
  }
}
