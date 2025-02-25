import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';

final selectedBikeProvider = StateProvider<BikeEntity?>((ref) => null);
