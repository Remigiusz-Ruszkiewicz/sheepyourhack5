import 'package:flutter/material.dart';
import 'package:harmony_app/src/activity_list/activity_list_view.dart';
import 'package:harmony_app/src/home_page/home_page_view.dart';
import 'package:harmony_app/src/progress_list/progress_list_view.dart';
import 'package:harmony_app/src/widgets/drawer_entry.dart';

class HarmonyDrawer extends StatelessWidget {
  const HarmonyDrawer({required this.drawerIcons, super.key});

  final List<IconData> drawerIcons;

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
              for (final icon in drawerIcons)
                if (_drawerEntries[icon] case final ({String title, Widget Function() builder}) entry)
                  DrawerEntry(
                    iconData: icon,
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

final Map<IconData, ({String title, Widget Function() builder})> _drawerEntries = {
  Icons.dashboard: (title: 'Dashboard', builder: () => const HomePageView()),
  Icons.task: (title: 'Przydziel zadania', builder: () => const ActivityListView()),
  Icons.task_alt: (title: 'Postępy', builder: () => const ActivityListView()),
  Icons.card_giftcard: (title: 'Nagrody', builder: () => const ProgressListView()),
  Icons.show_chart: (title: 'Statystyki', builder: () => const HomePageView()),
};
