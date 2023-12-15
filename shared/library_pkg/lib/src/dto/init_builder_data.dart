/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:flutter/material.dart';

class InitBuilderData {
  const InitBuilderData({
    Map<String, TextEditingController>? textControllers,
    Map<String, FocusNode>? focusNodes,
  })  : _textControllers = textControllers,
        _focusNodes = focusNodes;

  final Map<String, TextEditingController>? _textControllers;
  final Map<String, FocusNode>? _focusNodes;

  TextEditingController getTextController(String key) => _textControllers![key]!;

  FocusNode getFocusNode(String key) => _focusNodes![key]!;

  void dispose() {
    _textControllers?.forEach((_, value) => value.dispose());
    _focusNodes?.forEach((_, value) => value.dispose());
  }
}
