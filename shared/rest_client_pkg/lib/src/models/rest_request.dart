import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:rest_client_pkg/rest_client_pkg.dart';

@immutable
final class RestRequest<T> {
  const RestRequest(this.uri, {this.data, this.fromJson, this.headers, this.encoding});

  final String uri;
  final Object? data;
  final T Function(dynamic json)? fromJson;
  final Map<String, String>? headers;
  final Encoding? encoding;

  RestResponse<T> convertResponse(Response response) {
    final statusCode = RestStatusCodes.fromNumber(response.statusCode);
    final result = statusCode == RestStatusCodes.ok ? fromJson?.call(jsonDecode(response.body)) : null;
    return RestResponse<T>(statusCode: statusCode, result: result);
  }
}
