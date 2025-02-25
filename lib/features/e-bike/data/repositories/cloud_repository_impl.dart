import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:porsche_ebike_app/features/e-bike/data/services/api_service.dart';
import 'package:porsche_ebike_app/features/e-bike/data/services/cache_service.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';

import '../../domain/repositories/cloud_repository.dart';
import '../../data/services/cloud_service.dart';

class CloudRepositoryImpl implements CloudRepository {
  final CloudService cloudService;
  final apiService =
      ApiService(baseUrl: dotenv.env['BASE_URL'] ?? 'https://www.example.com');

  CloudRepositoryImpl({required this.cloudService});

  @override
  Future<Map<String, String>> fetchModelAssets(BikeModel model) async {
    try {
      final cacheService = await CacheService.create();
      final cachedData = await cacheService.loadData(model);

      /// Return cached data (if required)
      // if (cachedData != null) {
      //   return cachedData;
      // }

      /// Mock api call for demonstrattion
      // final response = await apiService
      //     .getRequest('/cloud-repo?date=${DateTime.now()}&type=$model');

      /// Mock response and error handling
      // if (response.statusCode == 200) {
      //   return cloudService.fetchModelAssets(model);
      // } else {
      //   throw ServerException();
      // }

      return cloudService.fetchModelAssets(model);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
