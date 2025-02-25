import 'package:permission_handler/permission_handler.dart';

Future<void> requestMacOSPermissions() async {
  await [
    Permission.bluetooth,
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
    Permission.locationWhenInUse,
    Permission.location,
    Permission.storage,
  ].request();
}
