import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';
import 'package:porsche_ebike_app/features/e-bike/presentation/providers/scan_bikes_provider.dart';
import '../providers/selected_bike_provider.dart';

class DiscoveredBikesWidget extends ConsumerWidget {
  final AsyncValue<List<BikeEntity>> bikesAsync;

  const DiscoveredBikesWidget({super.key, required this.bikesAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Discovered Bikes',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: bikesAsync.when(
            data: (bikes) => ListView.builder(
              itemCount: bikes.length,
              itemBuilder: (context, index) {
                final bike = bikes[index];
                return ListTile(
                  title: Text('ID: ${bike.id}'),
                  subtitle: Text(bike.model.name),
                  trailing: ElevatedButton(
                    onPressed: () {
                      ref.read(selectedBikeProvider.notifier).state = bike;
                    },
                    child: const Text('Connect'),
                  ),
                );
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error'),
          ),
        )),
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: ElevatedButton(
            onPressed: () => ref.read(scanBikesProvider.notifier).scan(),
            style: ElevatedButton.styleFrom(fixedSize: const Size(0, 45)),
            child: const Text('Scan Bikes'),
          ),
        ),
      ],
    );
  }
}
