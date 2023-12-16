import 'package:collection/collection.dart';

enum RestStatusCodes {
  unknown(1024),

  /// Success
  ok(200),
  noContent(204),

  /// Client Error
  badRequest(400),
  unauthorized(401),
  forbidden(403),
  notFound(404),
  methodNotAllowed(405),

  /// Server Error
  internalServerError(500),
  notImplemented(501),
  badGateway(502),
  serviceUnavailable(503),
  gatewayTimeout(504);

  const RestStatusCodes(this.value);

  factory RestStatusCodes.fromNumber(int i) {
    return RestStatusCodes.values.firstWhereOrNull((x) => x.value == i) ?? unknown;
  }

  final int value;
}
