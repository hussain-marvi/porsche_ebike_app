import 'package:porsche_ebike_app/core/usecase.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';
import '../../data/services/usb_service.dart';
import '../../data/services/ble_service.dart';

class ScanBikesUseCase implements UseCase<List<BikeEntity>, NoParams> {
  final USBService usbService;
  final BLEService bleService;

  ScanBikesUseCase({required this.usbService, required this.bleService});

  @override
  Future<List<BikeEntity>> call(NoParams params) async {
    final usbBikes = await usbService.scan();
    final bleBikes = await bleService.scan();
    // Combine both lists; deduplication logic can be added as needed.
    return [...usbBikes, ...bleBikes];
  }
}
