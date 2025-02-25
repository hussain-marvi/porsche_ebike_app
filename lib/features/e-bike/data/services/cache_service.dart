import 'package:porsche_ebike_app/features/e-bike/data/services/dependency_injection.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/entities/bike.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String cacheKey = 'energy_data';
  static late SharedPreferences prefs;

  CacheService._create();

  static Future<CacheService> create() async {
    // Call the private constructor
    var component = CacheService._create();
    // Do initialization that requires async
    await getIt.isReady<SharedPreferences>();
    prefs = getIt<SharedPreferences>();
    // Return the fully initialized object
    return component;
  }

  Future<void> saveData(String metric, List<BikeModel> data) async {
    // final jsonData = data
    //     .map((e) => {
    //           'datetime': e.datetime.toIso8601String(),
    //           'value': e.value,
    //         })
    //     .toList();
    // prefs.setString('$cacheKey-$metric', json.encode(jsonData));
  }

  Future<List<BikeEntity>?>? loadData(BikeModel model) async {
    final jsonString = prefs.getString('$cacheKey-$model');
    if (jsonString != null) {
      // List<dynamic> jsonData = json.decode(jsonString);
      // return jsonData.map((e) => BikeEntity.fromJson(e)).toList();
    }
    return null;
  }

  // Clear cache for all metrics
  Future<void> clearAllData() async {
    // final keys = prefs.getKeys().where((key) => key.startsWith(cacheKey));
    // for (final key in keys) {
    //   await prefs.remove(key);
    // }

    await prefs.clear();
  }
}
