import 'package:flutter/material.dart';

enum DrawerRoute {
  home(Icons.dashboard),
  activityAssign(Icons.task),
  progress(Icons.task_alt),
  rewards(Icons.card_giftcard),
  statistics(Icons.show_chart);

  const DrawerRoute(this.drawerIcon);

  final IconData drawerIcon;
}
