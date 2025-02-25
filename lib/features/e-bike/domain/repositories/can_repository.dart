import '../../data/services/can_service.dart';

abstract class CANRepository {
  Future<void> sendMessage(CANMessage message);
  Future<CANMessage> receiveMessage();
}
