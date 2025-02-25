import 'package:porsche_ebike_app/core/usecase.dart';
import '../repositories/can_repository.dart';
import '../../data/services/can_service.dart';

class SendCANMessageParams {
  final CANMessage message;

  SendCANMessageParams({required this.message});
}

class SendCANMessageUseCase implements UseCase<void, SendCANMessageParams> {
  final CANRepository canRepository;

  SendCANMessageUseCase({required this.canRepository});

  @override
  Future<void> call(SendCANMessageParams params) {
    return canRepository.sendMessage(params.message);
  }
}
