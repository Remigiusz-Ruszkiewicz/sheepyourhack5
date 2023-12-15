import 'dart:typed_data';

abstract interface class SocketConnection {
  abstract final Stream<Uint8List> inputStream;
  abstract final void Function(Uint8List bytes) outputWrite;
}
