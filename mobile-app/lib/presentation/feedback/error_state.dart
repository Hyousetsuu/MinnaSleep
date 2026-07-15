// Sprint 19: Error State UI
// Friendly error screens avoiding technical jargon.

class ErrorStateUI {
  void renderNetworkError() {
    print("🌙 Sepertinya koneksi sedang istirahat juga. Tarik ke bawah untuk mencoba lagi.");
  }

  void renderSyncError() {
    print("Mungkin penghemat baterai membatasi sinkronisasi. Coba lagi nanti ya.");
  }
}
