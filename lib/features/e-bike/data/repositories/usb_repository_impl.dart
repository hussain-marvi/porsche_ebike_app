import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';

import '../../domain/repositories/usb_repository.dart';
import '../../data/services/usb_service.dart';

class USBRepositoryImpl implements USBRepository {
  final USBService usbService;

  USBRepositoryImpl({required this.usbService});

  @override
  Future<List<BikeEntity>> scan() => usbService.scan();

  @override
  Stream<Map<String, dynamic>> getDataStream(String bikeId) =>
      usbService.getDataStream(bikeId);
}
