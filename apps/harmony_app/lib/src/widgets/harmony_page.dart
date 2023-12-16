import 'package:flutter/material.dart';
import 'package:harmony_app/src/widgets/drawer_appbar.dart';
import 'package:harmony_app/src/widgets/harmony_drawer.dart';

class HarmonyPage extends StatelessWidget {
  const HarmonyPage({required this.drawerIcons, required this.body, super.key});

  final List<IconData> drawerIcons;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: const DrawerAppBar(),
        endDrawer: HarmonyDrawer(
          drawerIcons: drawerIcons,
        ),
        body: body,
      ),
    );
  }
}
