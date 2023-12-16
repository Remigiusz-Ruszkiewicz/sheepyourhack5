import 'package:flutter/foundation.dart';
import 'package:rest_client_pkg/src/enums/rest_status_codes.dart';

@immutable
final class RestResponse<T> {
  const RestResponse({required this.statusCode, this.result});

  final RestStatusCodes statusCode;
  final T? result;
}
