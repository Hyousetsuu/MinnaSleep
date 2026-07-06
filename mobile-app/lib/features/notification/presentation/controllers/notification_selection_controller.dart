import 'package:flutter/foundation.dart';

class NotificationSelectionController extends ChangeNotifier {
  final Set<String> _selectedIds = {};

  bool get isSelectionMode => _selectedIds.isNotEmpty;
  int get selectedCount => _selectedIds.length;
  Set<String> get selectedIds => _selectedIds;

  bool isSelected(String id) => _selectedIds.contains(id);

  void toggleSelection(String id) {
    if (_selectedIds.contains(id)) {
      _selectedIds.remove(id);
    } else {
      _selectedIds.add(id);
    }
    notifyListeners();
  }

  void selectAll(List<String> allIds) {
    _selectedIds.addAll(allIds);
    notifyListeners();
  }

  void clearSelection() {
    _selectedIds.clear();
    notifyListeners();
  }
}
