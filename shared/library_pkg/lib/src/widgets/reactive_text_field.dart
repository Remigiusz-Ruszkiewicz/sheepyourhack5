import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_pkg/src/models/reactive_input_decoration.dart';

class ReactiveTextField extends TextField {
  const ReactiveTextField({
    required ReactiveInputDecoration super.decoration,
    super.controller,
    super.focusNode,
    super.undoController,
    super.keyboardType,
    super.textInputAction,
    super.textCapitalization = TextCapitalization.none,
    super.style,
    super.strutStyle,
    super.textAlign = TextAlign.start,
    super.textAlignVertical,
    super.textDirection,
    super.readOnly = false,
    super.showCursor,
    super.autofocus = false,
    super.obscuringCharacter = '•',
    super.obscureText = false,
    super.autocorrect = true,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions = true,
    super.maxLines = 1,
    super.minLines,
    super.expands = false,
    super.maxLength,
    super.maxLengthEnforcement,
    super.onChanged,
    super.onEditingComplete,
    super.onSubmitted,
    super.onAppPrivateCommand,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth = 2.0,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorOpacityAnimates,
    super.cursorColor,
    super.selectionHeightStyle = ui.BoxHeightStyle.tight,
    super.selectionWidthStyle = ui.BoxWidthStyle.tight,
    super.keyboardAppearance,
    super.scrollPadding = const EdgeInsets.all(20),
    super.dragStartBehavior = DragStartBehavior.start,
    super.enableInteractiveSelection,
    super.selectionControls,
    super.onTap,
    super.onTapOutside,
    super.mouseCursor,
    super.buildCounter,
    super.scrollController,
    super.scrollPhysics,
    super.autofillHints = const <String>[],
    super.contentInsertionConfiguration,
    super.clipBehavior = Clip.hardEdge,
    super.restorationId,
    super.scribbleEnabled = true,
    super.enableIMEPersonalizedLearning = true,
    super.contextMenuBuilder,
    super.canRequestFocus = true,
    super.spellCheckConfiguration,
    super.magnifierConfiguration,
    super.key,
  });

  @override
  ReactiveInputDecoration get decoration => super.decoration! as ReactiveInputDecoration;

  @override
  State<ReactiveTextField> createState() => _ReactiveTextFieldState();
}

class _ReactiveTextFieldState extends State<ReactiveTextField>
    with RestorationMixin
    implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController => widget.controller ?? _controller!.value;

  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  MaxLengthEnforcement get _effectiveMaxLengthEnforcement =>
      widget.maxLengthEnforcement ??
      LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(Theme.of(context).platform);

  bool _isHovering = false;

  bool get needsCounter => widget.maxLength != null && widget.decoration.counterText == null;

  bool _showSelectionHandles = false;

  late _TextFieldSelectionGestureDetectorBuilder _selectionGestureDetectorBuilder;

  // API for TextSelectionGestureDetectorBuilderDelegate.
  @override
  late bool forcePressEnabled;

  @override
  final GlobalKey<EditableTextState> editableTextKey = GlobalKey<EditableTextState>();

  @override
  bool get selectionEnabled => widget.selectionEnabled;

  // End of API for TextSelectionGestureDetectorBuilderDelegate.

  bool get _isEnabled => widget.enabled ?? widget.decoration.enabled;

  int get _currentLength => _effectiveController.value.text.characters.length;

  bool get _hasIntrinsicError =>
      widget.maxLength != null &&
      widget.maxLength! > 0 &&
      _effectiveController.value.text.characters.length > widget.maxLength!;

  bool get _hasError => widget.decoration.errorText != null || _hasIntrinsicError;

  Color get _errorColor => widget.decoration.errorStyle?.color ?? Theme.of(context).colorScheme.error;

  ReactiveInputDecoration _getEffectiveDecoration() {
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final ThemeData themeData = Theme.of(context);
    final ReactiveInputDecoration effectiveDecoration =
        widget.decoration.applyDefaults(themeData.inputDecorationTheme).copyWith(
              enabled: _isEnabled,
              hintMaxLines: widget.decoration.hintMaxLines ?? widget.maxLines,
            );

    // No need to build anything if counter or counterText were given directly.
    if (effectiveDecoration.counter != null || effectiveDecoration.counterText != null) {
      return effectiveDecoration;
    }

    // If buildCounter was provided, use it to generate a counter widget.
    Widget? counter;
    final int currentLength = _currentLength;
    if (effectiveDecoration.counter == null && effectiveDecoration.counterText == null && widget.buildCounter != null) {
      final bool isFocused = _effectiveFocusNode.hasFocus;
      final Widget? builtCounter = widget.buildCounter!(
        context,
        currentLength: currentLength,
        maxLength: widget.maxLength,
        isFocused: isFocused,
      );
      // If buildCounter returns null, don't add a counter widget to the field.
      if (builtCounter != null) {
        counter = Semantics(
          container: true,
          liveRegion: isFocused,
          child: builtCounter,
        );
      }
      return effectiveDecoration.copyWith(counter: counter);
    }

    if (widget.maxLength == null) {
      return effectiveDecoration;
    } // No counter widget

    String counterText = '$currentLength';
    String semanticCounterText = '';

    // Handle a real maxLength (positive number)
    if (widget.maxLength! > 0) {
      // Show the maxLength in the counter
      counterText += '/${widget.maxLength}';
      final int remaining = (widget.maxLength! - currentLength).clamp(0, widget.maxLength!); // ignore_clamp_double_lint
      semanticCounterText = localizations.remainingTextFieldCharacterCount(remaining);
    }

    if (_hasIntrinsicError) {
      return effectiveDecoration.copyWith(
        errorText: effectiveDecoration.errorText ?? '',
        counterStyle: effectiveDecoration.errorStyle ??
            (themeData.useMaterial3 ? _m3CounterErrorStyle(context) : _m2CounterErrorStyle(context)),
        counterText: counterText,
        semanticCounterText: semanticCounterText,
      );
    }

    return effectiveDecoration.copyWith(
      counterText: counterText,
      semanticCounterText: semanticCounterText,
    );
  }

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder = _TextFieldSelectionGestureDetectorBuilder(state: this);
    if (widget.controller == null) {
      _createLocalController();
    }
    _effectiveFocusNode
      ..canRequestFocus = widget.canRequestFocus && _isEnabled
      ..addListener(_handleFocusChanged);
  }

  bool get _canRequestFocus {
    final NavigationMode mode = MediaQuery.maybeNavigationModeOf(context) ?? NavigationMode.traditional;
    switch (mode) {
      case NavigationMode.traditional:
        return widget.canRequestFocus && _isEnabled;
      case NavigationMode.directional:
        return true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _effectiveFocusNode.canRequestFocus = _canRequestFocus;
  }

  @override
  void didUpdateWidget(ReactiveTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _createLocalController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      unregisterFromRestoration(_controller!);
      _controller!.dispose();
      _controller = null;
    }

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }

    _effectiveFocusNode.canRequestFocus = _canRequestFocus;

    if (_effectiveFocusNode.hasFocus && widget.readOnly != oldWidget.readOnly && _isEnabled) {
      if (_effectiveController.selection.isCollapsed) {
        _showSelectionHandles = !widget.readOnly;
      }
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) {
      _registerController();
    }
  }

  void _registerController() {
    assert(_controller != null, 'Controller need to be created first!');
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null, 'Controller already created');
    _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  EditableTextState? get _editableText => editableTextKey.currentState;

  void _requestKeyboard() {
    _editableText?.requestKeyboard();
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // When the text field is activated by something that doesn't trigger the
    // selection overlay, we shouldn't show the handles either.
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar) {
      return false;
    }
    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }
    if (widget.readOnly && _effectiveController.selection.isCollapsed) {
      return false;
    }
    if (!_isEnabled) {
      return false;
    }
    if (cause == SelectionChangedCause.longPress || cause == SelectionChangedCause.scribble) {
      return true;
    }
    if (_effectiveController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  void _handleFocusChanged() {
    setState(() {
      // Rebuild the widget on focus change to show/hide the text selection
      // highlight.
    });
  }

  void _handleSelectionChanged(TextSelection selection, SelectionChangedCause? cause) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        if (cause == SelectionChangedCause.longPress) {
          _editableText?.bringIntoView(selection.extent);
        }
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) {
          _editableText?.hideToolbar();
        }
    }
  }

  /// Toggle the toolbar when a selection handle is tapped.
  void _handleSelectionHandleTapped() {
    if (_effectiveController.selection.isCollapsed) {
      _editableText!.toggleToolbar();
    }
  }

  void _handleHover(bool hovering) {
    if (hovering != _isHovering) {
      setState(() {
        _isHovering = hovering;
      });
    }
  }

  // AutofillClient implementation start.
  @override
  String get autofillId => _editableText!.autofillId;

  @override
  void autofill(TextEditingValue newEditingValue) => _editableText!.autofill(newEditingValue);

  @override
  TextInputConfiguration get textInputConfiguration {
    final List<String>? autofillHints = widget.autofillHints?.toList(growable: false);
    final AutofillConfiguration autofillConfiguration = autofillHints != null
        ? AutofillConfiguration(
            uniqueIdentifier: autofillId,
            autofillHints: autofillHints,
            currentEditingValue: _effectiveController.value,
            hintText: widget.decoration.hintText,
          )
        : AutofillConfiguration.disabled;

    return _editableText!.textInputConfiguration.copyWith(autofillConfiguration: autofillConfiguration);
  }

  // AutofillClient implementation end.

  Set<MaterialState> get _materialState {
    return <MaterialState>{
      if (!_isEnabled) MaterialState.disabled,
      if (_isHovering) MaterialState.hovered,
      if (_effectiveFocusNode.hasFocus) MaterialState.focused,
      if (_hasError) MaterialState.error,
    };
  }

  TextStyle _getInputStyleForState(TextStyle style) {
    final ThemeData theme = Theme.of(context);
    final TextStyle stateStyle = MaterialStateProperty.resolveAs(
      theme.useMaterial3 ? _m3StateInputStyle(context)! : _m2StateInputStyle(context)!,
      _materialState,
    );
    final TextStyle providedStyle = MaterialStateProperty.resolveAs(style, _materialState);
    return providedStyle.merge(stateStyle);
  }

  @override
  Widget build(BuildContext context) {
    assert(
      debugCheckHasMaterial(context),
      "Given context doesn't have a Material ancestor within the closest LookupBoundary.",
    );
    assert(
      debugCheckHasMaterialLocalizations(context),
      "Given context doesn't have a Localizations ancestor that contains MaterialLocalizations delegate.",
    );
    assert(
      debugCheckHasDirectionality(context),
      "Given context doesn't have a Directionality ancestor.",
    );
    assert(
      !(widget.style != null &&
          widget.style!.inherit == false &&
          (widget.style!.fontSize == null || widget.style!.textBaseline == null)),
      'inherit false style must supply fontSize and textBaseline',
    );

    final ThemeData theme = Theme.of(context);
    final DefaultSelectionStyle selectionStyle = DefaultSelectionStyle.of(context);
    final TextStyle style =
        _getInputStyleForState(theme.useMaterial3 ? _m3InputStyle(context) : theme.textTheme.titleMedium!)
            .merge(widget.style);
    final Brightness keyboardAppearance = widget.keyboardAppearance ?? theme.brightness;
    final TextEditingController controller = _effectiveController;
    final FocusNode focusNode = _effectiveFocusNode;
    final List<TextInputFormatter> formatters = <TextInputFormatter>[
      ...?widget.inputFormatters,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(
          widget.maxLength,
          maxLengthEnforcement: _effectiveMaxLengthEnforcement,
        ),
    ];

    // Set configuration as disabled if not otherwise specified. If specified,
    // ensure that configuration uses the correct style for misspelled words for
    // the current platform, unless a custom style is specified.
    final SpellCheckConfiguration spellCheckConfiguration;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        spellCheckConfiguration = CupertinoTextField.inferIOSSpellCheckConfiguration(
          widget.spellCheckConfiguration,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        spellCheckConfiguration = TextField.inferAndroidSpellCheckConfiguration(
          widget.spellCheckConfiguration,
        );
    }

    TextSelectionControls? textSelectionControls = widget.selectionControls;
    final bool paintCursorAboveText;
    bool? cursorOpacityAnimates = widget.cursorOpacityAnimates;
    Offset? cursorOffset;
    final Color cursorColor;
    final Color selectionColor;
    Color? autocorrectionTextRectColor;
    Radius? cursorRadius = widget.cursorRadius;
    VoidCallback? handleDidGainAccessibilityFocus;

    switch (theme.platform) {
      case TargetPlatform.iOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = true;
        textSelectionControls ??= cupertinoTextSelectionControls;
        paintCursorAboveText = true;
        cursorOpacityAnimates ??= true;
        cursorColor =
            _hasError ? _errorColor : widget.cursorColor ?? selectionStyle.cursorColor ?? cupertinoTheme.primaryColor;
        selectionColor = selectionStyle.selectionColor ?? cupertinoTheme.primaryColor.withOpacity(0.40);
        cursorRadius ??= const Radius.circular(2);
        cursorOffset = Offset(iOSHorizontalOffset / MediaQuery.devicePixelRatioOf(context), 0);
        autocorrectionTextRectColor = selectionColor;

      case TargetPlatform.macOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = false;
        textSelectionControls ??= cupertinoDesktopTextSelectionControls;
        paintCursorAboveText = true;
        cursorOpacityAnimates ??= false;
        cursorColor =
            _hasError ? _errorColor : widget.cursorColor ?? selectionStyle.cursorColor ?? cupertinoTheme.primaryColor;
        selectionColor = selectionStyle.selectionColor ?? cupertinoTheme.primaryColor.withOpacity(0.40);
        cursorRadius ??= const Radius.circular(2);
        cursorOffset = Offset(iOSHorizontalOffset / MediaQuery.devicePixelRatioOf(context), 0);
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the TextField when it receives accessibility focus.
          if (!_effectiveFocusNode.hasFocus && _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };

      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        forcePressEnabled = false;
        textSelectionControls ??= materialTextSelectionControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates ??= false;
        cursorColor =
            _hasError ? _errorColor : widget.cursorColor ?? selectionStyle.cursorColor ?? theme.colorScheme.primary;
        selectionColor = selectionStyle.selectionColor ?? theme.colorScheme.primary.withOpacity(0.40);

      case TargetPlatform.linux:
        forcePressEnabled = false;
        textSelectionControls ??= desktopTextSelectionControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates ??= false;
        cursorColor =
            _hasError ? _errorColor : widget.cursorColor ?? selectionStyle.cursorColor ?? theme.colorScheme.primary;
        selectionColor = selectionStyle.selectionColor ?? theme.colorScheme.primary.withOpacity(0.40);

      case TargetPlatform.windows:
        forcePressEnabled = false;
        textSelectionControls ??= desktopTextSelectionControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates ??= false;
        cursorColor =
            _hasError ? _errorColor : widget.cursorColor ?? selectionStyle.cursorColor ?? theme.colorScheme.primary;
        selectionColor = selectionStyle.selectionColor ?? theme.colorScheme.primary.withOpacity(0.40);
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the TextField when it receives accessibility focus.
          if (!_effectiveFocusNode.hasFocus && _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };
    }

    Widget child = RepaintBoundary(
      child: UnmanagedRestorationScope(
        bucket: bucket,
        child: EditableText(
          key: editableTextKey,
          readOnly: widget.readOnly || !_isEnabled,
          showCursor: widget.showCursor,
          showSelectionHandles: _showSelectionHandles,
          controller: controller,
          focusNode: focusNode,
          undoController: widget.undoController,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          style: style,
          strutStyle: widget.strutStyle,
          textAlign: widget.textAlign,
          textDirection: widget.textDirection,
          autofocus: widget.autofocus,
          obscuringCharacter: widget.obscuringCharacter,
          obscureText: widget.obscureText,
          autocorrect: widget.autocorrect,
          smartDashesType: widget.smartDashesType,
          smartQuotesType: widget.smartQuotesType,
          enableSuggestions: widget.enableSuggestions,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          expands: widget.expands,
          // Only show the selection highlight when the text field is focused.
          selectionColor: focusNode.hasFocus ? selectionColor : null,
          selectionControls: widget.selectionEnabled ? textSelectionControls : null,
          onChanged: widget.onChanged,
          onSelectionChanged: _handleSelectionChanged,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          onAppPrivateCommand: widget.onAppPrivateCommand,
          onSelectionHandleTapped: _handleSelectionHandleTapped,
          onTapOutside: widget.onTapOutside,
          inputFormatters: formatters,
          rendererIgnoresPointer: true,
          mouseCursor: MouseCursor.defer,
          // TextField will handle the cursor
          cursorWidth: widget.cursorWidth,
          cursorHeight: widget.cursorHeight,
          cursorRadius: cursorRadius,
          cursorColor: cursorColor,
          selectionHeightStyle: widget.selectionHeightStyle,
          selectionWidthStyle: widget.selectionWidthStyle,
          cursorOpacityAnimates: cursorOpacityAnimates,
          cursorOffset: cursorOffset,
          paintCursorAboveText: paintCursorAboveText,
          backgroundCursorColor: CupertinoColors.inactiveGray,
          scrollPadding: widget.scrollPadding,
          keyboardAppearance: keyboardAppearance,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          dragStartBehavior: widget.dragStartBehavior,
          scrollController: widget.scrollController,
          scrollPhysics: widget.scrollPhysics,
          autofillClient: this,
          autocorrectionTextRectColor: autocorrectionTextRectColor,
          clipBehavior: widget.clipBehavior,
          restorationId: 'editable',
          scribbleEnabled: widget.scribbleEnabled,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          contentInsertionConfiguration: widget.contentInsertionConfiguration,
          contextMenuBuilder: widget.contextMenuBuilder,
          spellCheckConfiguration: spellCheckConfiguration,
          magnifierConfiguration: widget.magnifierConfiguration ?? TextMagnifier.adaptiveMagnifierConfiguration,
        ),
      ),
    );

    final decoration = widget.decoration;
    final prefixChangeNotifier = decoration.decorationNotifier;
    child = AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[
        focusNode,
        controller,
        widget.decoration.decorationNotifier,
      ]),
      builder: (BuildContext context, Widget? child) {
        return InputDecorator(
          decoration: _getEffectiveDecoration().copyWith(prefixText: prefixChangeNotifier.prefixText),
          baseStyle: widget.style,
          textAlign: widget.textAlign,
          textAlignVertical: widget.textAlignVertical,
          isHovering: _isHovering,
          isFocused: focusNode.hasFocus,
          isEmpty: controller.value.text.isEmpty,
          expands: widget.expands,
          child: child,
        );
      },
      child: child,
    );

    final MouseCursor effectiveMouseCursor = MaterialStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? MaterialStateMouseCursor.textable,
      _materialState,
    );

    final int? semanticsMaxValueLength;
    if (_effectiveMaxLengthEnforcement != MaxLengthEnforcement.none &&
        widget.maxLength != null &&
        widget.maxLength! > 0) {
      semanticsMaxValueLength = widget.maxLength;
    } else {
      semanticsMaxValueLength = null;
    }

    return MouseRegion(
      cursor: effectiveMouseCursor,
      onEnter: (PointerEnterEvent event) => _handleHover(true),
      onExit: (PointerExitEvent event) => _handleHover(false),
      child: TextFieldTapRegion(
        child: IgnorePointer(
          ignoring: !_isEnabled,
          child: AnimatedBuilder(
            animation: controller, // changes the _currentLength
            builder: (BuildContext context, Widget? child) {
              return Semantics(
                maxValueLength: semanticsMaxValueLength,
                currentValueLength: _currentLength,
                onTap: widget.readOnly
                    ? null
                    : () {
                        if (!_effectiveController.selection.isValid) {
                          _effectiveController.selection =
                              TextSelection.collapsed(offset: _effectiveController.text.length);
                        }
                        _requestKeyboard();
                      },
                onDidGainAccessibilityFocus: handleDidGainAccessibilityFocus,
                child: child,
              );
            },
            child: _selectionGestureDetectorBuilder.buildGestureDetector(
              behavior: HitTestBehavior.translucent,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _TextFieldSelectionGestureDetectorBuilder extends TextSelectionGestureDetectorBuilder {
  _TextFieldSelectionGestureDetectorBuilder({
    required _ReactiveTextFieldState state,
  })  : _state = state,
        super(delegate: state);

  final _ReactiveTextFieldState _state;

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {
    // Not required.
  }

  @override
  void onSingleTapUp(TapDragUpDetails details) {
    super.onSingleTapUp(details);
    _state._requestKeyboard();
    _state.widget.onTap?.call();
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    super.onSingleLongTapStart(details);
    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          Feedback.forLongPress(_state.context);
      }
    }
  }
}

TextStyle? _m2StateInputStyle(BuildContext context) => MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
      final ThemeData theme = Theme.of(context);
      if (states.contains(MaterialState.disabled)) {
        return TextStyle(color: theme.disabledColor);
      }
      return TextStyle(color: theme.textTheme.titleMedium?.color);
    });

TextStyle _m2CounterErrorStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error);

TextStyle? _m3StateInputStyle(BuildContext context) => MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.38));
      }
      return TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color);
    });

TextStyle _m3InputStyle(BuildContext context) => Theme.of(context).textTheme.bodyLarge!;

TextStyle _m3CounterErrorStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error);
