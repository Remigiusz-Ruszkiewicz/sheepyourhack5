import 'package:flutter/material.dart';

class DrawerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DrawerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        Builder(
          builder: (context) => DrawerButton(
            style: IconButton.styleFrom(
              iconSize: 36,
              foregroundColor: Colors.black,
            ),
            onPressed: () => Scaffold.maybeOf(context)?.openEndDrawer(),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
