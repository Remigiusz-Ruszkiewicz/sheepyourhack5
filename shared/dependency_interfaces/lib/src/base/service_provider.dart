import 'package:dependency_interfaces/dependency_interfaces.dart'
    show BackgroundServiceCommand, BackgroundWrapper, Logger, Service;

typedef ProviderInitializer<T> = T Function(BackgroundWrapper backgroundWrapper);

typedef ServiceInitializer<T extends Service> = T Function(
  Map<BackgroundServiceCommand, Service> services,
  BackgroundServiceCommand backgroundCommand,
);

Future<PROVIDER> createAsync<PROVIDER, SERVICE extends Service>(
  ProviderInitializer<PROVIDER> providerSupplier,
  ServiceInitializer<SERVICE> serviceSupplier,
  BackgroundWrapper backgroundWrapper, {
  Logger? logger,
}) async {
  await backgroundWrapper.registerService(serviceSupplier);
  final instance = providerSupplier.call(backgroundWrapper);
  logger?.d('Service $instance initialized');
  return instance;
}
