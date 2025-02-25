// lib/presentation/ui/main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porsche_ebike_app/features/e-bike/presentation/layouts/bike_readings.dart';
import 'package:porsche_ebike_app/features/e-bike/presentation/layouts/discovered_bikes.dart';
import 'package:porsche_ebike_app/features/e-bike/presentation/layouts/model_overview.dart';
import '../providers/scan_bikes_provider.dart';
import '../providers/selected_bike_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikesAsync = ref.watch(scanBikesProvider);
    final selectedBike = ref.watch(selectedBikeProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: DiscoveredBikesWidget(bikesAsync: bikesAsync),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: selectedBike != null
                  ? BikeReadingsWidget(bikeId: selectedBike.id)
                  : const Center(child: Text('No bike selected')),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: selectedBike != null
                  ? ModelOverviewWidget(model: selectedBike.model)
                  : const Center(child: Text('No model selected')),
            ),
          ],
        ),
      ),
    );
  }
}
