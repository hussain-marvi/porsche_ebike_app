import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';
import '../providers/model_assets_provider.dart';

class ModelOverviewWidget extends ConsumerWidget {
  final BikeModel model;

  const ModelOverviewWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetsAsync = ref.watch(modelAssetsProvider(model));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Model Overview',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: assetsAsync.when(
              data: (assets) => Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      assets['title'] ?? '',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      assets['description'] ?? '',
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 50),
                    Expanded(
                      child: Image.network(
                        assets['imageUrl'] ?? '',
                        height: 500,
                        width: 500,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 150),
                      ),
                    ),
                  ],
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Error: $error'),
            ),
          ),
        )
      ],
    );
  }
}
