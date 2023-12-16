import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_device.freezed.dart';

part 'saved_device.g.dart';

@freezed
class SavedDevice with _$SavedDevice {
  const factory SavedDevice({
    required String name,
    required String address,
    required String fullName,
  }) = _SavedDevice;

  factory SavedDevice.fromJson(Map<String, Object?> json) => _$SavedDeviceFromJson(json);
}
