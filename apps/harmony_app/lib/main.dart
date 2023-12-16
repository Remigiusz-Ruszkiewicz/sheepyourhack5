import 'dart:async';
import 'dart:ui';

import 'package:background_worker_pkg/background_worker_pkg.dart';
import 'package:dependency_interfaces/dependency_interfaces.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/libra_widget/libra_widget.dart';
import 'package:library_pkg/library_pkg.dart';
import 'package:local_storage_pkg/local_storage_pkg.dart';
import 'package:localization_pkg/localization_pkg.dart';
import 'package:logger_pkg/logger_pkg.dart';
import 'package:permission_handler_pkg/permission_handler_pkg.dart';
import 'package:platform_info_pkg/platform_info_pkg.dart';
import 'package:rest_client_pkg/rest_client_pkg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  _registerDependencies();
  runApp(LocalizationWidget(child: const HarmonyApp()));
}

class HarmonyApp extends StatelessWidget {
  const HarmonyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Harmony',
      theme: darkTheme,
      home: const SafeArea(
        child: Scaffold(
          body: LibraWidget(),
        ),
      ),
    );
  }
}

void _registerDependencies() {
  final getIt = GetIt.instance;
  getIt
    ..registerSingletonAsync<Logger>(
      () => LoggerProvider.createAsync('harmony'),
      dispose: (service) => service.dispose(),
    )
    ..registerSingletonAsync<PermissionHandler>(
      () => PermissionProvider.createAsync(
        getIt.get<PlatformInfo>().version,
        logger: getIt.get<Logger>(),
      ),
      dependsOn: [Logger],
    )
    ..registerSingletonAsync<BackgroundWorker>(
      () => BackgroundWorkerProvider.createAsync(RootIsolateToken.instance!),
      dispose: (worker) => worker.dispose(),
    )
    ..registerSingletonAsync<LocalStorageProvider>(
      () => LocalStorageProvider.createAsync(
        getIt.get<BackgroundWorker>(),
        logger: getIt.get<Logger>(),
      ),
      dependsOn: [BackgroundWorker, Logger],
      dispose: (service) => service.dispose(),
    )
    ..registerLazySingleton<PlatformInfo>(PlatformInfoProvider.new)
    ..registerLazySingletonAsync<RestClientProvider>(
      () => RestClientProvider.createAsync(
        getIt.get<BackgroundWorker>(),
        logger: getIt.get<Logger>(),
      ),
      dispose: (service) => service.dispose(),
    );
}
