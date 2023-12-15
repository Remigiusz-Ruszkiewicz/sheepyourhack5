import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';

class HarmonyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HarmonyAppBar({
    required this.title,
    this.subTitle,
    this.leading,
    this.leadingWidth = kToolbarHeight,
    this.automaticallyImplyLeading = true,
    this.hideLeadingStream,
    this.trailingWidgets,
    super.key,
  });

  final String title;
  final String? subTitle;
  final Widget? leading;
  final double leadingWidth;
  final bool automaticallyImplyLeading;
  final Stream<bool>? hideLeadingStream;
  final List<Widget>? trailingWidgets;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: Container(),
      toolbarHeight: kToolbarHeight,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
          ),
          if (subTitle != null)
            Text(
              subTitle!,
            ),
        ],
      ),
      titleSpacing: 0,
      leadingWidth: leadingWidth,
      leading: hideLeadingStream != null
          ? AsyncBuilder<bool>(
              stream: hideLeadingStream!.distinct(),
              retain: true,
              builder: (context, value) {
                if (value == true) {
                  return const SizedBox.shrink();
                }
                return leading ?? const BackButton();
              },
            )
          : leading,
      actions: trailingWidgets,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
