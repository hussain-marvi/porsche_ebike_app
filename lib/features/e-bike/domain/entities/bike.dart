enum BikeModel { metroBee, cliffHanger }

abstract class BikeEntity {
  final String id;
  final BikeModel model;

  BikeEntity({required this.id, required this.model});
}
