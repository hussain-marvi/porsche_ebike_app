import 'package:porsche_ebike_app/core/usecase.dart';

import '../repositories/can_repository.dart';
import '../../data/services/can_service.dart';

class ReceiveCANMessageUseCase implements UseCase<CANMessage, NoParams> {
  final CANRepository canRepository;

  ReceiveCANMessageUseCase({required this.canRepository});

  @override
  Future<CANMessage> call(NoParams params) {
    return canRepository.receiveMessage();
  }
}
