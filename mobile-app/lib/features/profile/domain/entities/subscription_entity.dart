class SubscriptionEntity {
  final String userId;
  final SubscriptionPlan plan;
  final DateTime? expiredAt;
  final bool isAutoRenew;

  const SubscriptionEntity({
    required this.userId,
    this.plan = SubscriptionPlan.free,
    this.expiredAt,
    this.isAutoRenew = false,
  });

  bool get isPremium {
    if (plan == SubscriptionPlan.free) return false;
    if (expiredAt == null) return true; // Lifetime
    return expiredAt!.isAfter(DateTime.now());
  }
}

enum SubscriptionPlan {
  free,
  premiumMonthly,
  premiumYearly,
  premiumLifetime,
}
