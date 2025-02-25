import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';

abstract class CloudRepository {
  Future<Map<String, String>> fetchModelAssets(BikeModel model);
}
