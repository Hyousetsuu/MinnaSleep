// Sprint 19: Success State UI
// Explicit confirmation of actions.

class SuccessStateUI {
  void showSuccessToast(String message) {
    print("✓ $message");
  }

  void showSyncSuccess(int scoreIncrease) {
    print("✓ Data dari Health Connect berhasil diperbarui. Recovery Score naik +$scoreIncrease%.");
  }
}
