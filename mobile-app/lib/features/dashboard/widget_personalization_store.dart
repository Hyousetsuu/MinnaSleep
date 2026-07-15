// Sprint 19: Widget Personalization Store
// Allows users to customize their dashboard layout (like Garmin Connect).

class WidgetPersonalizationStore {
  List<Map<String, dynamic>> activeWidgets = [
    {'id': 'RECOVERY_SCORE', 'size': 'LARGE', 'visible': true},
    {'id': 'SLEEP_DEBT', 'size': 'MEDIUM', 'visible': true},
    {'id': 'AI_COACH', 'size': 'LARGE', 'visible': true},
    {'id': 'FRIENDS_FEED', 'size': 'SMALL', 'visible': false}
  ];

  void reorderWidget(int oldIndex, int newIndex) {
    print("[Dashboard] Reordered widgets.");
  }

  void hideWidget(String widgetId) {
    print("[Dashboard] Widget $widgetId hidden.");
  }

  void resizeWidget(String widgetId, String newSize) {
    print("[Dashboard] Widget $widgetId resized to $newSize.");
  }
}
