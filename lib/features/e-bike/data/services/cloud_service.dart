import 'dart:async';
import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';

class CloudService {
  /// Fetches cloud-based assets for the given bike model.
  Future<Map<String, String>> fetchModelAssets(BikeModel model) async {
    // Simulate network latency
    await Future.delayed(const Duration(seconds: 2));
    if (model == BikeModel.metroBee) {
      return {
        'title': 'MetroBee',
        'description':
            'Conquer the concrete jungle with effortless speed and style. Glide through traffic, beat rush-hour, and make every ride a breeze.',
        'imageUrl':
            'https://shop.porsche.com/_next/image?url=https%3A%2F%2Fimages.ctfassets.net%2F1oyzmkwpf3d5%2F3qlVNYb8YlY1a6P2s4ZIYe%2F33e00fb39822d716824b1ffdcbb7d8ae%2F3zu4_Teaser_Tile_1.jpg&w=2560&q=75',
      };
    } else if (model == BikeModel.cliffHanger) {
      return {
        'title': 'CliffHanger',
        'description':
            'The CliffHanger is engineered for challenging mountain conditions with robust performance.',
        'imageUrl':
            'https://ebike-mtb.com/wp-content/uploads/sites/2/2019/07/Porsch-E-MTB-Rotwild-RX-Turbo-023-1140x760.jpg',
      };
    } else {
      return {
        'title': 'Unkown',
        'description': 'Unknown model.',
        'imageUrl':
            'https://via.placeholder.com/150/FFFFFF/000000?text=Unknown',
      };
    }
  }
}
