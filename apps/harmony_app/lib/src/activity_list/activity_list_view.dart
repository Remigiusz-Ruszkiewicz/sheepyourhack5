import 'dart:async';

import 'package:comprehensive_utils/comprehensive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/enums/drawer_route.dart';
import 'package:harmony_app/src/widgets/harmony_page.dart';
import 'package:library_pkg/library_pkg.dart';
import 'package:rxdart/rxdart.dart';

import '../enums/activity_type.dart';
import '../models/task.dart';
import '../widgets/badge_widget.dart';
import '../widgets/menu_list_item.dart';

class ActivityListView extends StatelessWidget {
  const ActivityListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<Bloc>(
      instance: Bloc.new,
      child: HarmonyPage(
        drawerRoutes: const [
          DrawerRoute.statistics,
          DrawerRoute.home,
          DrawerRoute.progress,
          DrawerRoute.rewards,
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            children: [
              const Text(
                'Wybierz aktywność z listy',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 36),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter your text here',
                    hintStyle: TextStyle(color: Colors.black),
                    focusColor: Colors.transparent,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ),
              FluentListView<MapEntry<Task, bool>>(
                retain: true,
                stream: GetIt.I.get<Bloc>().tasksSubject.stream,
                // itemComparator: EqualityBy<Task, String>((entry) => entry.uid).equals,
                waiting: (_) => const Center(child: CircularProgressIndicator()),
                itemBuilder: (_, index, entry) => InkWell(
                  onTap: () {
                    final a = GetIt.I.get<Bloc>().tasksSubject.value.toList();
                    final item = !entry.value;
                    a[index] = MapEntry(entry.key, item);
                    GetIt.I.get<Bloc>().tasksSubject.add(a);
                  },
                  child: MenuListItem(task: entry!.key),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Bloc implements Disposable {
  Bloc();

  BehaviorSubject<List<MapEntry<Task, bool>>> tasksSubject = BehaviorSubject<List<MapEntry<Task, bool>>>();

  @override
  Future<void> onDispose() async {
    await tasksSubject.close();
  }
}

const List<MapEntry<Task, bool>> _mock = [
  MapEntry(
    Task(
      name: 'Czytanie książki',
      uid: '1',
      widget: BadgeWidget(
        icon: Icons.menu_book_outlined,
        pointsValue: 5,
      ),
      points: 5,
      activityType: ActivityType.education,
    ),
    false,
  ),
  MapEntry(
    Task(
      name: 'Czytanie książki',
      uid: '1',
      widget: BadgeWidget(
        icon: Icons.menu_book_outlined,
        pointsValue: 5,
      ),
      points: 5,
      activityType: ActivityType.education,
    ),
    false,
  ),
  MapEntry(
    Task(
      name: 'Czytanie książki',
      uid: '1',
      widget: BadgeWidget(
        icon: Icons.menu_book_outlined,
        pointsValue: 5,
      ),
      points: 5,
      activityType: ActivityType.education,
    ),
    false,
  ),
  MapEntry(
    Task(
      name: 'Czytanie książki',
      uid: '1',
      widget: BadgeWidget(
        icon: Icons.menu_book_outlined,
        pointsValue: 5,
      ),
      points: 5,
      activityType: ActivityType.education,
    ),
    false,
  ),
];
