// lib/data/services/analytics_service.dart
import 'dart:async';

class AnalyticsService {
  /// Reports a "Bike Connected" event to the analytics backend.
  Future<void> reportBikeConnected(String bikeId) async {
    final timestamp = DateTime.now().toIso8601String();
    // Simulate reporting delay
    await Future.delayed(const Duration(seconds: 1));
    print('Analytics Event - Bike Connected: Bike ID: $bikeId at $timestamp');
  }
}
