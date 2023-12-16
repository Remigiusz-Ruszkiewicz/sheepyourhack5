import 'package:flutter/material.dart';
import 'package:harmony_app/src/activity_list/activity_list_view.dart';
import 'package:harmony_app/src/enums/drawer_route.dart';
import 'package:harmony_app/src/home_page/home_page_view.dart';
import 'package:harmony_app/src/progress_list/progress_list_view.dart';
import 'package:harmony_app/src/widgets/drawer_entry.dart';

class HarmonyDrawer extends StatelessWidget {
  const HarmonyDrawer({required this.drawerRoutes, super.key});

  final List<DrawerRoute> drawerRoutes;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final route in drawerRoutes)
                if (_drawerEntries[route] case final ({String title, Widget Function() builder}) entry)
                  DrawerEntry(
                    iconData: route.drawerIcon,
                    title: entry.title,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute<void>(builder: (_) => entry.builder()));
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

final Map<DrawerRoute, ({String title, Widget Function() builder})> _drawerEntries = {
  DrawerRoute.home: (title: 'Dashboard', builder: () => const HomePageView()),
  DrawerRoute.activityAssign: (title: 'Przydziel zadania', builder: () => const ActivityListView()),
  DrawerRoute.progress: (title: 'Postępy', builder: () => const ActivityListView()),
  DrawerRoute.rewards: (title: 'Nagrody', builder: () => const ProgressListView()),
  DrawerRoute.statistics: (title: 'Statystyki', builder: () => const HomePageView()),
};
