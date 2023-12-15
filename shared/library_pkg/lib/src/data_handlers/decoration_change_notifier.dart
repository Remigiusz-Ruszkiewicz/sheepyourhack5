import 'package:flutter/material.dart';

class DecorationChangeNotifier extends ChangeNotifier {
  factory DecorationChangeNotifier({String? prefixText, String? suffixText}) {
    final instance = DecorationChangeNotifier.empty();
    return instance
      .._prefix = prefixText?._asDecorationOf(instance)
      .._suffix = suffixText?._asDecorationOf(instance);
  }

  DecorationChangeNotifier.empty();

  _ReactiveDecorationText? _prefix;
  _ReactiveDecorationText? _suffix;

  String? get prefixText => _prefix?.text;

  set prefixText(String? newText) {
    (_prefix ??= _ReactiveDecorationText.empty(_notifyListeners)).text = newText;
  }

  String? get suffixText => _suffix?.text;

  set suffixText(String? newText) {
    (_suffix ??= _ReactiveDecorationText.empty(_notifyListeners)).text = newText;
  }

  void _notifyListeners() => super.notifyListeners();
}

class _ReactiveDecorationText {
  _ReactiveDecorationText(this._notify, this._text);

  _ReactiveDecorationText.empty(this._notify);

  final VoidCallback _notify;

  String? _text;

  String? get text => _text;

  set text(String? newText) {
    _text = newText;
    _notify();
  }
}

extension on String {
  _ReactiveDecorationText _asDecorationOf(DecorationChangeNotifier instance) {
    return _ReactiveDecorationText(instance._notifyListeners, this);
  }
}
