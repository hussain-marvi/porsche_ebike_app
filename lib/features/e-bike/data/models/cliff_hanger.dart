import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';

class CliffHanger extends BikeEntity {
  /// Continuous stream of 3-axis gyroscope readings.
  final List<double>? gyroscope;

  /// Total airtime in seconds, available on request.
  final int? totalAirtime;

  CliffHanger({
    required super.id,
    this.gyroscope,
    this.totalAirtime,
  }) : super(model: BikeModel.cliffHanger);
}
