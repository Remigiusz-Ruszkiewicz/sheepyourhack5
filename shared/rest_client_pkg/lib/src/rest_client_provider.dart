import 'dart:async';
import 'dart:convert';

import 'package:dependency_interfaces/dependency_interfaces.dart' as dep
    show BackgroundServiceCommand, BackgroundWorker, BackgroundWrapper, Logger, RestClient, createAsync;
import 'package:rest_client_pkg/src/enums/rest_client_commands.dart';
import 'package:rest_client_pkg/src/instances/rest_client_service.dart';
import 'package:rest_client_pkg/src/models/rest_request.dart';
import 'package:rest_client_pkg/src/models/rest_response.dart';

final class RestClientProvider implements dep.RestClient {
  RestClientProvider._(this._backgroundService);

  final dep.BackgroundWrapper _backgroundService;

  static Future<RestClientProvider> createAsync(dep.BackgroundWorker backgroundWorker, {dep.Logger? logger}) =>
      dep.createAsync<RestClientProvider, RestClientService>(
        RestClientProvider._,
        RestClientService.new,
        dep.BackgroundWrapper(backgroundWorker, dep.BackgroundServiceCommand.restClient),
        logger: logger,
      );

  @override
  Future<RestResponse<T>> get<T>(
    String uri, {
    T Function(dynamic)? fromJson,
    Map<String, String>? headers,
  }) {
    return _backgroundService.runForResult<RestResponse<T>, RestRequest<T>>(
      RestClientCommand.post,
      RestRequest<T>(uri, fromJson: fromJson, headers: headers),
    );
  }

  @override
  Future<RestResponse<T>> post<T>(
    String uri, {
    Object? data,
    T Function(dynamic)? fromJson,
    Map<String, String>? headers,
    Encoding? encoding,
  }) {
    return _backgroundService.runForResult<RestResponse<T>, RestRequest<T>>(
      RestClientCommand.post,
      RestRequest<T>(
        uri,
        data: data,
        fromJson: fromJson,
        headers: headers,
        encoding: encoding,
      ),
    );
  }

  @override
  void put() {
    // TODO(KD): implement put
    throw UnimplementedError();
  }

  @override
  void delete() {
    // TODO(KD): implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> dispose() async {
    await _backgroundService.runVoid<void>(RestClientCommand.dispose);
  }
}
