import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porsche_ebike_app/core/usecase.dart';
import 'package:porsche_ebike_app/features/e-bike/data/services/dependency_injection.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';
import '../../domain/usecases/scan_bikes_usecase.dart';

/// Provides the list of scanned bikes via USB and BLE.
final scanBikesProvider =
    StateNotifierProvider<ScanBikesNotifier, AsyncValue<List<BikeEntity>>>(
        (ref) {
  final scanBikesUseCase = getIt<ScanBikesUseCase>();
  return ScanBikesNotifier(scanBikesUseCase: scanBikesUseCase);
});

/// Manages the scan operation.
class ScanBikesNotifier extends StateNotifier<AsyncValue<List<BikeEntity>>> {
  final ScanBikesUseCase scanBikesUseCase;

  ScanBikesNotifier({required this.scanBikesUseCase})
      : super(const AsyncValue.loading());

  /// Triggers a bike scan.
  Future<void> scan() async {
    state = const AsyncValue.loading(); // Set loading state
    try {
      final bikes = await scanBikesUseCase(NoParams());
      state = AsyncValue.data(bikes); // Update state with fetched bikes
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace); // Handle error
    }
  }
}
