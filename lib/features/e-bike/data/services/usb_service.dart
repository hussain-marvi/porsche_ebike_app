// lib/data/services/usb_service.dart
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

import '../../data/models/metro_bee.dart';
import '../../data/models/cliff_hanger.dart';

class USBService {
  final StreamController<Map<String, dynamic>> _dataStreamController =
      StreamController.broadcast();
  UsbPort? _port;
  StreamSubscription<String>? _subscription;

  /// Scans for available bikes via USB connectivity.
  Future<List<BikeEntity>> scan() async {
    // To fetch list of connected usb devices
    // List<UsbDevice> devices = await UsbSerial.listDevices();

    // Simulate USB scan delay
    await Future.delayed(const Duration(seconds: 2));
    // Return dummy bikes for demonstration
    return [
      MetroBee(id: 'USB-001'),
      CliffHanger(id: 'USB-002'),
    ];
  }

  /// Parses raw USB serial data into structured JSON-like data.
  Map<String, dynamic> _parseUSBData(String data) {
    List<String> values = data.split(',');
    return {
      "motorRpm": int.tryParse(values[0]) ?? 0,
      "batteryCharge": int.tryParse(values[1]) ?? 0,
      "odoMeter": int.tryParse(values[2]) ?? 0,
    };
  }

  /// Connects to a USB Serial device.
  Future<void> connect(UsbDevice device) async {
    _port = await device.create();
    if (_port == null) {
      throw Exception("Unable to open port");
    }

    bool openResult = await _port!.open();
    if (!openResult) {
      throw Exception("Failed to open USB connection");
    }

    _port!.setDTR(true);
    _port!.setRTS(true);
    _port!.setPortParameters(
        115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    Transaction<String> transaction =
        Transaction.stringTerminated(_port!.inputStream!, '\n' as Uint8List);
    _subscription = transaction.stream.listen((data) {
      // Convert raw string data to a map
      Map<String, dynamic> parsedData = _parseUSBData(data);
      _dataStreamController.add(parsedData);
    });
  }

  /// Streams real-time data from a connected bike via USB.
  Stream<Map<String, dynamic>> getDataStream(String bikeId) {
    // Simulate continuous data stream from USB
    return Stream.periodic(const Duration(seconds: 1), (count) {
      return {
        'Bike_Id': 9879873,
        'State_Of_Charge': 80 - (count % 5),
        'ODO_Meter': 100 + count * 2,
        'Last_Known_Error': Random().nextInt(9999),
        'Last_anti-theft_alert': DateTime.now()
      };
    });
  }

  /// Disconnects from the USB device.
  Future<void> disconnect() async {
    _subscription?.cancel();
    await _port?.close();
    _port = null;
    _dataStreamController.close();
  }
}
