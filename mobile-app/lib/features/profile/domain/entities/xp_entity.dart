class XpEntity {
  final int currentXp;

  const XpEntity({
    this.currentXp = 0,
  });

  // Calculate level based on specific brackets
  int get level {
    if (currentXp < 100) return 1;
    if (currentXp < 300) return 2;
    if (currentXp < 700) return 3;
    if (currentXp < 1500) return 4;
    return 5 + ((currentXp - 1500) ~/ 1000); // Level 5 and beyond
  }

  // Calculate the XP required for the NEXT level
  int get xpForNextLevel {
    final currentLevel = level;
    if (currentLevel == 1) return 100;
    if (currentLevel == 2) return 300;
    if (currentLevel == 3) return 700;
    if (currentLevel == 4) return 1500;
    return 1500 + ((currentLevel - 4) * 1000);
  }

  // Calculate the XP of the CURRENT level baseline
  int get xpForCurrentLevel {
    final currentLevel = level;
    if (currentLevel == 1) return 0;
    if (currentLevel == 2) return 100;
    if (currentLevel == 3) return 300;
    if (currentLevel == 4) return 700;
    return 1500 + ((currentLevel - 5) * 1000);
  }

  double get levelProgress {
    final xpInCurrentLevel = currentXp - xpForCurrentLevel;
    final xpNeededForNext = xpForNextLevel - xpForCurrentLevel;
    if (xpNeededForNext <= 0) return 1.0;
    return (xpInCurrentLevel / xpNeededForNext).clamp(0.0, 1.0);
  }

  int get xpRemaining => xpForNextLevel - currentXp;
}
