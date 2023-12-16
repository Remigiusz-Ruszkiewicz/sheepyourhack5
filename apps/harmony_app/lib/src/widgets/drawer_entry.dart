import 'package:flutter/material.dart';

class DrawerEntry extends StatelessWidget {
  const DrawerEntry({required this.iconData, required this.title, required this.onPressed, super.key});

  final IconData iconData;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 36),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
