import 'package:porsche_ebike_app/core/stream_usecase.dart';

import '../repositories/usb_repository.dart';
import '../repositories/ble_repository.dart';

class GetBikeReadingsUseCase
    implements StreamUseCase<Map<String, dynamic>, String> {
  final USBRepository usbRepository;
  final BLERepository bleRepository;

  GetBikeReadingsUseCase(
      {required this.usbRepository, required this.bleRepository});

  @override
  Stream<Map<String, dynamic>> call(String bikeId) {
    if (bikeId.startsWith("USB")) {
      return usbRepository.getDataStream(bikeId);
    } else if (bikeId.startsWith("BLE")) {
      return bleRepository.getDataStream(bikeId);
    } else {
      return Stream.error(Exception("Invalid bike ID format"));
    }
  }
}
