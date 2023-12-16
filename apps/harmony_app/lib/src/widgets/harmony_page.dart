import 'package:flutter/material.dart';
import 'package:harmony_app/src/enums/drawer_route.dart';
import 'package:harmony_app/src/widgets/drawer_appbar.dart';
import 'package:harmony_app/src/widgets/harmony_drawer.dart';

class HarmonyPage extends StatelessWidget {
  const HarmonyPage({required this.drawerRoutes, required this.body, super.key});

  final List<DrawerRoute> drawerRoutes;
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
          drawerRoutes: drawerRoutes,
        ),
        body: body,
      ),
    );
  }
}
