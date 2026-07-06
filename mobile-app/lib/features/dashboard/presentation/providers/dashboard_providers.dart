import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/repositories/dashboard_repository.dart';
import '../data/repositories/mock_dashboard_repository.dart';
import '../data/models/dashboard_models.dart';

// Provide the repository
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return MockDashboardRepository();
});

// Provide the state
final dashboardProvider = FutureProvider.autoDispose<DashboardData>((ref) async {
  final repo = ref.watch(dashboardRepositoryProvider);
  return repo.getDashboardData();
});
