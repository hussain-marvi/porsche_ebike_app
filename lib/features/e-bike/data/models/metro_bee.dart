import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';

class MetroBee extends BikeEntity {
  /// The last theft alert timestamp. This field is updated on request.
  final DateTime? lastTheftAlert;

  MetroBee({
    required super.id,
    this.lastTheftAlert,
  }) : super(model: BikeModel.metroBee);
}
