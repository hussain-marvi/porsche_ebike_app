import 'dart:async';
import 'dart:convert';

/// Represents a simple CAN message.
class CANMessage {
  final int id;
  final Map<String, dynamic> data;

  CANMessage({required this.id, required this.data});

  /// Serializes the CAN message to a JSON string.
  String serialize() {
    return jsonEncode({'id': id, 'data': data});
  }

  /// Deserializes a JSON string into a CANMessage.
  static CANMessage deserialize(String message) {
    final decoded = jsonDecode(message);
    return CANMessage(
      id: decoded['id'],
      data: Map<String, dynamic>.from(decoded['data']),
    );
  }
}

/// Simulates CAN message transmission and reception.
class CANService {
  /// Simulates sending a CAN message.
  Future<void> sendMessage(CANMessage message) async {
    // Simulate a slight transmission delay
    await Future.delayed(const Duration(milliseconds: 500));
    print('Sending CAN Message: ${message.serialize()}');
  }

  /// Simulates receiving a CAN message.
  Future<CANMessage> receiveMessage() async {
    // Simulate a slight reception delay
    await Future.delayed(const Duration(milliseconds: 500));
    final dummyMessage = CANMessage(id: 100, data: {'value': 42});
    print('Received CAN Message: ${dummyMessage.serialize()}');
    return dummyMessage;
  }
}
