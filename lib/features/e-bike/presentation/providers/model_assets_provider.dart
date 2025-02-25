import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porsche_ebike_app/features/e-bike/data/services/dependency_injection.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/usecases/fetch_model_assets_usecase.dart';

/// Provides the cloud-based assets (image, description) for a given bike model.
final modelAssetsProvider =
    FutureProvider.family<Map<String, String>, BikeModel>(
  (ref, model) async {
    final fetchModelAssetsUseCase = getIt<FetchModelAssetsUseCase>();
    return await fetchModelAssetsUseCase(model);
  },
);
