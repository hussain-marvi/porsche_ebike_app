// lib/data/repositories/can_repository_impl.dart
import '../../domain/repositories/can_repository.dart';
import '../../data/services/can_service.dart';

class CANRepositoryImpl implements CANRepository {
  final CANService canService;

  CANRepositoryImpl({required this.canService});

  @override
  Future<void> sendMessage(CANMessage message) =>
      canService.sendMessage(message);

  @override
  Future<CANMessage> receiveMessage() => canService.receiveMessage();
}
