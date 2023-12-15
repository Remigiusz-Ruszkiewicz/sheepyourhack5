import 'package:freezed_annotation/freezed_annotation.dart';
part 'live_data_response.freezed.dart';
part 'live_data_response.g.dart';

@freezed
class LiveDataResponse with _$LiveDataResponse {
  const factory LiveDataResponse({
    int? precision,
    DateTime? dateOfLastAnswer,
    double? min,
    double? value,
    double? max,
    String? prefix,
    String? unit,
    String? measureType,
  }) = _LiveDataResponse;

  factory LiveDataResponse.fromJson(Map<String, Object?> json) => _$LiveDataResponseFromJson(json);
}
