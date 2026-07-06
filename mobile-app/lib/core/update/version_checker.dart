class VersionChecker {
  // Simulates comparing versions. Returns 0 if equal, 1 if current > latest, -1 if current < latest
  static int compare(String currentVersion, String latestVersion) {
    List<int> currentParts = currentVersion.split('.').map(int.parse).toList();
    List<int> latestParts = latestVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      if (currentParts[i] < latestParts[i]) return -1;
      if (currentParts[i] > latestParts[i]) return 1;
    }
    return 0;
  }

  static bool isUpdateRequired(String currentVersion, String minimumRequiredVersion) {
    return compare(currentVersion, minimumRequiredVersion) < 0;
  }
}
