import 'package:porsche_ebike_app/core/usecase.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';

import '../repositories/cloud_repository.dart';

class FetchModelAssetsUseCase
    implements UseCase<Map<String, String>, BikeModel> {
  final CloudRepository cloudRepository;

  FetchModelAssetsUseCase({required this.cloudRepository});

  @override
  Future<Map<String, String>> call(BikeModel model) {
    return cloudRepository.fetchModelAssets(model);
  }
}
