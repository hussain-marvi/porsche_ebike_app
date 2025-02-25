import 'package:porsche_ebike_app/core/usecase.dart';
import '../repositories/analytics_repository.dart';

class ReportBikeConnectedParams {
  final String bikeId;

  ReportBikeConnectedParams({required this.bikeId});
}

class ReportBikeConnectedUseCase
    implements UseCase<void, ReportBikeConnectedParams> {
  final AnalyticsRepository analyticsRepository;

  ReportBikeConnectedUseCase({required this.analyticsRepository});

  @override
  Future<void> call(ReportBikeConnectedParams params) {
    return analyticsRepository.reportBikeConnected(params.bikeId);
  }
}
