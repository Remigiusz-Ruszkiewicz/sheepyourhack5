/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:dependency_interfaces/dependency_interfaces.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:library_pkg/library_pkg.dart';

typedef Initializations = List<AsyncCallback>;

class StartupInitialization extends StatefulWidget {
  const StartupInitialization({
    required this.child,
    required WidgetBuilder placeholder,
    Initializations initializations = const [],
    this.permissionCheck,
    Initializations postInitializations = const [],
    super.key,
  })  : _initializations = initializations,
        _postInitializations = postInitializations,
        _placeholderBuilder = placeholder,
        _headerTitle = null;

  const StartupInitialization.waiting({
    required this.child,
    required String headerTitle,
    Initializations initializations = const [],
    this.permissionCheck,
    Initializations postInitializations = const [],
    super.key,
  })  : _initializations = initializations,
        _postInitializations = postInitializations,
        _placeholderBuilder = null,
        _headerTitle = headerTitle;

  final Widget child;
  final Initializations _initializations;
  final PermissionCheckDTO? permissionCheck;
  final Initializations _postInitializations;
  final WidgetBuilder? _placeholderBuilder;
  final String? _headerTitle;

  @override
  State<StartupInitialization> createState() => _StartupInitializationState();
}

class _StartupInitializationState extends State<StartupInitialization> {
  bool initialized = false;

  @override
  void initState() {
    assert(
      widget._initializations.isNotEmpty || widget.permissionCheck != null,
      'At least one initialization function or permission must be provided',
    );
    super.initState();
    _init(widget._initializations, widget.permissionCheck, widget._postInitializations).then((_) {
      setState(() {
        initialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return widget.child;
    }
    final placeholder = widget._placeholderBuilder?.call(context);
    if (placeholder != null) {
      return placeholder;
    }
    return Scaffold(
      appBar: GossenAppBar(
        title: widget._headerTitle!,
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _init(
    Initializations initializations,
    PermissionCheckDTO? permissionCheck,
    Initializations postInitializations,
  ) async {
    if (initializations.isNotEmpty) {
      await Future.wait<void>([
        for (final init in initializations) init.call(),
      ]);
    }
    if (permissionCheck != null) {
      await _checkPermissions(permissionCheck);
    }
    if (postInitializations.isNotEmpty) {
      await Future.wait<void>([
        for (final init in postInitializations) init.call(),
      ]);
    }
  }

  Future<bool> _checkPermissions(PermissionCheckDTO permissionCheck) async {
    final permissionHandler = await permissionCheck.permissionHandler;
    final result = await permissionHandler.requestPermissions(permissionCheck.permissions);
    return result || await permissionHandler.retryRequests();
  }
}
