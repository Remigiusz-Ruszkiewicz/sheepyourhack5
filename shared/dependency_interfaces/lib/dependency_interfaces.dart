/// Module
library dependency_interfaces;

export 'src/base/serial_socket.dart';
export 'src/base/service.dart';
export 'src/base/service_provider.dart';
export 'src/base/socket_connection.dart';
export 'src/enums/background_service_command.dart';
export 'src/helpers/background_worker.dart';
export 'src/helpers/message_wrapper.dart';
export 'src/helpers/reverse_redirect.dart' hide ReverseRedirect;
export 'src/interfaces/background_worker.dart';
export 'src/interfaces/bluetooth.dart';
export 'src/interfaces/connection_checker.dart';
export 'src/interfaces/local_database.dart';
export 'src/interfaces/local_storage.dart';
export 'src/interfaces/location.dart';
export 'src/interfaces/logger.dart';
export 'src/interfaces/metrahit_handler.dart';
export 'src/interfaces/mqtt_client.dart';
export 'src/interfaces/nearby_devices.dart';
export 'src/interfaces/permission_handler.dart' hide Permission;
export 'src/interfaces/platform_info.dart';
export 'src/interfaces/rest_client.dart';
export 'src/interfaces/serial_communication.dart';
export 'src/platform_identifier.dart';
