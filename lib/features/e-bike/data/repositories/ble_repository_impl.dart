import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';

import '../../domain/repositories/ble_repository.dart';
import '../../data/services/ble_service.dart';

class BLERepositoryImpl implements BLERepository {
  final BLEService bleService;

  BLERepositoryImpl({required this.bleService});

  @override
  Future<List<BikeEntity>> scan() => bleService.scan();

  @override
  Stream<Map<String, dynamic>> getDataStream(String bikeId) =>
      bleService.getDataStream(bikeId);
}
