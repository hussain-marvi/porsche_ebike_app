import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:porsche_ebike_app/features/e-bike/data/services/api_service.dart';

import '../../domain/repositories/analytics_repository.dart';
import '../../data/services/analytics_service.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AnalyticsService analyticsService;
  final apiService =
      ApiService(baseUrl: dotenv.env['BASE_URL'] ?? 'https://www.example.com');

  AnalyticsRepositoryImpl({required this.analyticsService});

  @override
  Future<void> reportBikeConnected(String bikeId) async {
    /// Mock api call for demonstrattion
    // final response = await apiService.getRequest('/analytics?bikeId=$bikeId');
    try {
      /// Mock response and error handling
      // if (response.statusCode == 200) {
      //   return analyticsService.reportBikeConnected(bikeId);
      // } else {
      //   throw ServerException();
      // }

      return analyticsService.reportBikeConnected(bikeId);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
