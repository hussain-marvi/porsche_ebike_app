import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:porsche_ebike_app/core/usecase.dart';
import 'package:porsche_ebike_app/features/e-bike/data/models/cliff_hanger.dart';
import 'package:porsche_ebike_app/features/e-bike/data/models/metro_bee.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';

import 'package:porsche_ebike_app/features/e-bike/domain/repositories/usb_repository.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/repositories/ble_repository.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/usecases/scan_bikes_usecase.dart';

// Auto-generate mock classes
import 'scan_bikes_usecase_test.mocks.dart';

@GenerateMocks([
  USBRepository,
  BLERepository,
  BikeEntity,
  ScanBikesUseCase,
]) // This tells mockito to create mock classes
void main() {
  late MockUSBRepository mockUSBRepository;
  late MockBLERepository mockBLERepository;
  late MockScanBikesUseCase mockScanBikesUseCase;

  setUp(() {
    mockUSBRepository = MockUSBRepository(); // Concrete mock object
    mockBLERepository = MockBLERepository(); // Concrete mock object
    mockScanBikesUseCase = MockScanBikesUseCase();
  });

  test('Should return list of bikes from USB and BLE', () async {
    List<BikeEntity> usbBikes = [MetroBee(id: 'USB-001')];
    List<BikeEntity> bleBikes = [CliffHanger(id: 'USB-002')];

    when(mockUSBRepository.scan()).thenAnswer((_) async => usbBikes);
    when(mockBLERepository.scan()).thenAnswer((_) async => bleBikes);

    // Act
    final result = await mockScanBikesUseCase(NoParams());

    // Assert
    expect(result, containsAll([...usbBikes, ...bleBikes]));
    verify(mockUSBRepository.scan()).called(1);
    verify(mockBLERepository.scan()).called(1);
  });
}
