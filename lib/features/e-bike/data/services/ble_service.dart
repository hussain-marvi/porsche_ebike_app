import 'dart:async';
import 'dart:math';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';

import '../../data/models/metro_bee.dart';
import '../../data/models/cliff_hanger.dart';

class BLEService {
  final StreamController<Map<String, dynamic>> _dataStreamController =
      StreamController.broadcast();
  BluetoothDevice? _connectedDevice;
  // ignore: unused_field
  BluetoothCharacteristic? _characteristic;

  /// Scans for available bikes via BLE connectivity.
  Future<List<BikeEntity>> scan() async {
    List<BluetoothDevice> foundDevices = [];
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (!foundDevices.contains(r.device)) {
          foundDevices.add(r.device);
        }
      }
    });

    // Simulate BLE scan delay
    await Future.delayed(const Duration(seconds: 5));
    FlutterBluePlus.stopScan();
    if (foundDevices.isEmpty) {
      // Return dummy bikes for demonstration
      return [
        MetroBee(id: 'BLE-001'),
        CliffHanger(id: 'BLE-002'),
      ];
    } else {
      // Return available bikes for demonstration
      return [
        MetroBee(id: 'BLE-${foundDevices[0].remoteId}'),
        CliffHanger(id: 'BLE-${foundDevices[1].remoteId}'),
      ];
    }
  }

  /// Connects to a BLE device and starts streaming data.
  Future<void> connect(BluetoothDevice device) async {
    await device.connect();
    _connectedDevice = device;

    // Discover services & characteristics
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.notify) {
          _characteristic = characteristic;
          await characteristic.setNotifyValue(true);
          characteristic.onValueReceived.listen((data) {
            // Convert raw bytes to meaningful data
            _dataStreamController
                .add({"motorRpm": data[0], "batteryCharge": data[1]});
          });
        }
      }
    }
  }

  /// Streams real-time data from a connected bike via BLE.
  Stream<Map<String, dynamic>> getDataStream(String bikeId) {
    /// Live stream data for the connected bikes.
    // return _dataStreamController.stream;

    // Simulate BLE data stream for demonstration
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

  /// Disconnects from the BLE device.
  Future<void> disconnect() async {
    if (_connectedDevice != null) {
      await _connectedDevice!.disconnect();
      _connectedDevice = null;
      _dataStreamController.close();
    }
  }
}
