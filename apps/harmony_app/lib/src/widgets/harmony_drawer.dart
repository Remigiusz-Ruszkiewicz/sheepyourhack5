import 'package:flutter/material.dart';
import 'package:harmony_app/src/activity_list/activity_list_view.dart';
import 'package:harmony_app/src/enums/drawer_route.dart';
import 'package:harmony_app/src/home_page/home_page_view.dart';
import 'package:harmony_app/src/progress_list/progress_list_view.dart';
import 'package:harmony_app/src/ranking/ranking_view.dart';
import 'package:harmony_app/src/statistics/statistics_view.dart';
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
                if (_drawerEntries[route] case final ({String title, ValueGetter<Widget> builder}) entry)
                  DrawerEntry(
                    iconData: route.drawerIcon,
                    title: entry.title,
                    onPressed: () => Navigator.of(context)
                      ..pop()
                      ..push(MaterialPageRoute<void>(builder: (_) => entry.builder())),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

const Map<DrawerRoute, ({String title, ValueGetter<Widget> builder})> _drawerEntries = {
  DrawerRoute.home: (title: 'Dashboard', builder: HomePageView.new),
  DrawerRoute.activityAssign: (title: 'Przydziel zadania', builder: ActivityListView.new),
  DrawerRoute.progress: (title: 'Ranking', builder: RankingView.new),
  DrawerRoute.rewards: (title: 'Nagrody', builder: ProgressListView.new),
  DrawerRoute.statistics: (title: 'Statystyki', builder: StatisticsView.new),
};
