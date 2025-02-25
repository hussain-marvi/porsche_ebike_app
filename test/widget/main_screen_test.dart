import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:porsche_ebike_app/core/usecase.dart';
import 'package:porsche_ebike_app/features/e-bike/data/models/cliff_hanger.dart';
import 'package:porsche_ebike_app/features/e-bike/data/models/metro_bee.dart';
import 'package:porsche_ebike_app/features/e-bike/presentation/providers/scan_bikes_provider.dart';
import 'package:porsche_ebike_app/features/e-bike/presentation/views/main_screen.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/usecases/scan_bikes_usecase.dart';

// Generate mock classes
@GenerateMocks([ScanBikesUseCase])
import 'main_screen_test.mocks.dart';

void main() {
  late MockScanBikesUseCase mockScanBikesUseCase;

  setUp(() {
    mockScanBikesUseCase = MockScanBikesUseCase();
  });

  testWidgets('MainScreen displays "Scan Bikes" button and shows bikes',
      (WidgetTester tester) async {
    // Mock Data: Fake List of Bikes
    final fakeBikes = [
      MetroBee(id: 'USB-001'),
      CliffHanger(id: 'BLE-002'),
    ];

    // Mock the use case to return fake bikes
    when(mockScanBikesUseCase.call(NoParams()))
        .thenAnswer((_) async => fakeBikes);

    // Create a Fake ScanBikesNotifier
    final fakeScanBikesNotifier =
        ScanBikesNotifier(scanBikesUseCase: mockScanBikesUseCase)
          ..state = AsyncValue.data(fakeBikes); // Set Fake State

    // Pump Widget with Provider Override
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          scanBikesProvider
              .overrideWith((ref) => fakeScanBikesNotifier), // Correct Override
        ],
        child: const MaterialApp(home: MainScreen()),
      ),
    );

    await tester.pump();

    // Verify Button Exists
    expect(find.text('Scan Bikes'), findsOneWidget);

    // Verify Bike List Appears
    expect(find.text('USB-001'), findsOneWidget);
    expect(find.text('BLE-002'), findsOneWidget);
  });
}
