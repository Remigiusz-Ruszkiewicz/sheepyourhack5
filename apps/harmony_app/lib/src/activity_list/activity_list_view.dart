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
    return BlocBuilder<Bloc>(
      instance: Bloc.new,
      builder: (context, bloc) {
        return HarmonyPage(
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
                Expanded(
                  child: FluentListView<Task>(
                    retain: true,
                    stream: bloc.tasksSubject.stream,
                    waiting: (_) => const Center(child: CircularProgressIndicator()),
                    itemBuilder: (_, index, entry) => InkWell(
                      onTap: () {
                        final a = bloc.tasksSubject.value.toList();
                        a[index] = entry.copyWith(
                          widget: BadgeWidget(
                            icon: entry.icon,
                            pointsValue: int.parse(entry.points.toStringAsFixed(0)),
                            isSelected: !entry.isSelected,
                          ),
                        );
                        bloc.tasksSubject.add(a);
                      },
                      child: MenuListItem(task: entry!),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Bloc implements Disposable {
  Bloc();

  BehaviorSubject<List<Task>> tasksSubject = BehaviorSubject<List<Task>>.seeded(_mock);

  @override
  Future<void> onDispose() async {
    await tasksSubject.close();
  }
}

const List<Task> _mock = [
  Task(
    name: 'Czytanie książki',
    uid: '1',
    widget: BadgeWidget(
      icon: Icons.menu_book_outlined,
      pointsValue: 5,
    ),
    points: 5,
    activityType: ActivityType.education,
    icon: Icons.menu_book_outlined,
  ),
  Task(
    name: 'Czytanie książki',
    uid: '1',
    widget: BadgeWidget(
      icon: Icons.menu_book_outlined,
      pointsValue: 5,
    ),
    points: 5,
    activityType: ActivityType.education,
    icon: Icons.menu_book_outlined,
  ),
  Task(
    name: 'Czytanie książki',
    uid: '1',
    widget: BadgeWidget(
      icon: Icons.menu_book_outlined,
      pointsValue: 5,
    ),
    points: 5,
    activityType: ActivityType.education,
    icon: Icons.menu_book_outlined,
  ),
  Task(
    name: 'Czytanie książki',
    uid: '1',
    widget: BadgeWidget(
      icon: Icons.menu_book_outlined,
      pointsValue: 5,
    ),
    points: 5,
    activityType: ActivityType.education,
    icon: Icons.menu_book_outlined,
  ),
];
