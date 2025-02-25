import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porsche_ebike_app/features/e-bike/data/services/dependency_injection.dart';
import '../../domain/usecases/get_bike_readings_usecase.dart';

/// Provides real-time bike data for a connected bike.
final bikeReadingsProvider =
    StreamProvider.family<Map<String, dynamic>, String>((ref, bikeId) {
  final getBikeReadingsUseCase = getIt<GetBikeReadingsUseCase>();
  return getBikeReadingsUseCase(bikeId);
});
