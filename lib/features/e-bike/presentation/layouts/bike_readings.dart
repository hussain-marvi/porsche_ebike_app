import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bike_readings_provider.dart';

class BikeReadingsWidget extends ConsumerWidget {
  final String bikeId;

  const BikeReadingsWidget({super.key, required this.bikeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readingsStream = ref.watch(bikeReadingsProvider(bikeId));

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Text(
        'Bike Readings',
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
          child: readingsStream.when(
            data: (readings) => ListView(
              children: readings.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key.replaceAll('_', ' ')),
                  trailing: Text(entry.value.toString()),
                );
              }).toList(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error'),
          ),
        ),
      )
    ]);
  }
}
