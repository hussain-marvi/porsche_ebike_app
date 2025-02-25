import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';

abstract class BLERepository {
  Future<List<BikeEntity>> scan();
  Stream<Map<String, dynamic>> getDataStream(String bikeId);
}
