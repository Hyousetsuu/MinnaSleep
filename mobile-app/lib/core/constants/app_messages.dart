class AppMessages {
  // Empty States
  static const historyEmptyTitle = "Your sleep journey starts tonight.";
  static const historyEmptyBody = "We couldn't find any sleep records yet. Start tracking your first night to see your history.";
  static const analyticsEmptyTitle = "No Data Yet";
  static const analyticsEmptyBody = "Track a few nights to unlock your personalized sleep insights and trends.";
  static const notificationEmptyTitle = "You're all caught up!";
  static const notificationEmptyBody = "No new notifications right now. Have a good rest!";

  // Error States (Playful & Professional)
  static const networkErrorTitle = "Oops! Looks like your internet is taking a little nap. 🌙";
  static const networkErrorBody = "Don't worry—your sleep data is safely stored on this device and will sync automatically once you're back online.";
  
  static const unexpectedErrorTitle1 = "The sleep bugs bit our code. 🐞";
  static const unexpectedErrorTitle2 = "Something woke our app up unexpectedly. 🌙";
  static const unexpectedErrorTitle3 = "Our app is feeling a little sleepy. 😴";
  static const unexpectedErrorTitle4 = "Even good sleepers have rough nights. 🌙";
  
  static const unexpectedErrorBody = "Let's try that one more time and get things back on track.";

  // Sync Messages
  static const syncOffline = "📡 OFFLINE - Saving data locally...";
  static const syncUploading = "☁️ Syncing your sleep records...";
  static const syncComplete = "✅ Everything is up to date.";

  // Loading Messages
  static const loadingData = "Gathering your sleep data...";
  static const loadingWait = "Just a moment...";
  
  // Dashboard Motivation
  static const goalReachedTitle = "🎉 Great job!";
  static const goalReachedBody = "You reached your sleep goal today.";
  static const goalMissedTitle = "Almost there!";
  static String goalMissedBody(int minutesLeft) => "Only $minutesLeft minutes left to reach your goal.";
}
