import 'package:async_builder/async_builder.dart';
import 'package:comprehensive_utils/comprehensive_utils.dart';
import 'package:flutter/material.dart';
import 'package:nil/nil.dart';

class PageWithOverlay extends StatelessWidget {
  const PageWithOverlay({
    required this.overlay,
    required this.child,
    required this.loadingStream,
    this.initialLoading = false,
    super.key,
  });

  final Widget overlay;
  final Widget child;
  final Stream<bool> loadingStream;
  final bool initialLoading;

  @override
  Widget build(BuildContext context) {
    bool hasFired = initialLoading;
    return Stack(
      children: [
        Positioned.fill(child: child),
        AsyncBuilder<bool>(
          stream: loadingStream.shareDistinctValueSeeded(initialLoading),
          initial: initialLoading,
          retain: true,
          builder: (context, isLoading) {
            if (isLoading!) {
              hasFired = true;
              return Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) {
                      return const AbsorbPointer(
                        child: ColoredBox(
                          color: Colors.black26,
                          child: SizedBox.expand(),
                        ),
                      );
                    },
                  ),
                  OverlayEntry(builder: (context) => overlay),
                ],
              );
            }
            return hasFired ? const Nil() : const SizedBox.expand();
          },
        ),
      ],
    );
  }
}
