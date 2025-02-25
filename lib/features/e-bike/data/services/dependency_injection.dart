import 'package:get_it/get_it.dart';
import 'package:porsche_ebike_app/features/e-bike/data/repositories/analytics_repository_impl.dart';
import 'package:porsche_ebike_app/features/e-bike/data/repositories/ble_repository_impl.dart';
import 'package:porsche_ebike_app/features/e-bike/data/repositories/can_repository_impl.dart';
import 'package:porsche_ebike_app/features/e-bike/data/repositories/cloud_repository_impl.dart';
import 'package:porsche_ebike_app/features/e-bike/data/repositories/usb_repository_impl.dart';
import 'package:porsche_ebike_app/features/e-bike/data/services/analytics_service.dart';
import 'package:porsche_ebike_app/features/e-bike/data/services/ble_service.dart';
import 'package:porsche_ebike_app/features/e-bike/data/services/can_service.dart';
import 'package:porsche_ebike_app/features/e-bike/data/services/cloud_service.dart';
import 'package:porsche_ebike_app/features/e-bike/data/services/usb_service.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/repositories/analytics_repository.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/repositories/ble_repository.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/repositories/can_repository.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/repositories/cloud_repository.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/repositories/usb_repository.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/usecases/fetch_model_assets_usecase.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/usecases/get_bike_readings_usecase.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/usecases/receive_can_message_usecase.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/usecases/report_bike_connected_usecase.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/usecases/scan_bikes_usecase.dart';
import 'package:porsche_ebike_app/features/e-bike/domain/usecases/send_can_message_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  Future<void> setup() async {
    getIt.registerLazySingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance(),
    );

    // Register Services
    getIt.registerLazySingleton<USBService>(() => USBService());
    getIt.registerLazySingleton<BLEService>(() => BLEService());
    getIt.registerLazySingleton<CloudService>(() => CloudService());
    getIt.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
    getIt.registerLazySingleton<CANService>(() => CANService());

    // Register Repository Implementations using the service instances.
    getIt.registerLazySingleton<USBRepository>(
        () => USBRepositoryImpl(usbService: getIt<USBService>()));
    getIt.registerLazySingleton<BLERepository>(
        () => BLERepositoryImpl(bleService: getIt<BLEService>()));
    getIt.registerLazySingleton<CloudRepository>(
        () => CloudRepositoryImpl(cloudService: getIt<CloudService>()));
    getIt.registerLazySingleton<AnalyticsRepository>(() =>
        AnalyticsRepositoryImpl(analyticsService: getIt<AnalyticsService>()));
    getIt.registerLazySingleton<CANRepository>(
        () => CANRepositoryImpl(canService: getIt<CANService>()));

    // Register UseCases
    getIt.registerLazySingleton<ScanBikesUseCase>(() => ScanBikesUseCase(
        usbService: getIt<USBService>(), bleService: getIt<BLEService>()));
    getIt.registerLazySingleton<GetBikeReadingsUseCase>(() =>
        GetBikeReadingsUseCase(
            usbRepository: getIt<USBRepository>(),
            bleRepository: getIt<BLERepository>()));
    getIt.registerLazySingleton<FetchModelAssetsUseCase>(() =>
        FetchModelAssetsUseCase(cloudRepository: getIt<CloudRepository>()));
    getIt.registerLazySingleton<ReportBikeConnectedUseCase>(() =>
        ReportBikeConnectedUseCase(
            analyticsRepository: getIt<AnalyticsRepository>()));
    getIt.registerLazySingleton<SendCANMessageUseCase>(
        () => SendCANMessageUseCase(canRepository: getIt<CANRepository>()));
    getIt.registerLazySingleton<ReceiveCANMessageUseCase>(
        () => ReceiveCANMessageUseCase(canRepository: getIt<CANRepository>()));

    await getIt.isReady<SharedPreferences>();
  }
}
