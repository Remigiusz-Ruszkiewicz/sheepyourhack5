import 'package:collection/collection.dart';
import 'package:comprehensive_utils/comprehensive_utils.dart';
import 'package:flutter/material.dart';
import 'package:harmony_app/src/activity_list/activity_list_bloc.dart';
import 'package:harmony_app/src/enums/drawer_route.dart';
import 'package:harmony_app/src/models/task.dart';
import 'package:harmony_app/src/widgets/badge_widget.dart';
import 'package:harmony_app/src/widgets/harmony_page.dart';
import 'package:harmony_app/src/widgets/menu_list_item.dart';
import 'package:library_pkg/library_pkg.dart';

class ActivityListView extends StatelessWidget {
  const ActivityListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityListBloc>(
      instance: ActivityListBloc.new,
      builder: (context, bloc) {
        return HarmonyPage(
          drawerRoutes: const [
            DrawerRoute.statistics,
            DrawerRoute.home,
            DrawerRoute.progress,
            DrawerRoute.rewards,
          ],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
            child: OutlinedButton(
              style: OutlinedButtonTheme.of(context).style?.copyWith(
                    backgroundColor: const MaterialStatePropertyAll<Color>(Colors.purple),
                    foregroundColor: const MaterialStatePropertyAll<Color>(Colors.purple),
                  ),
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Dodaj do moich aktywności'),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
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
                  child: SizedBox(
                    child: FluentListView<Task>(
                      retain: true,
                      stream: bloc.tasksStream,
                      cacheExtent: double.maxFinite,
                      keepAlive: true,
                      itemComparator: EqualityBy<Task, String>((entry) => entry.name).equals,
                      waiting: (_) => const Center(child: CircularProgressIndicator()),
                      itemBuilder: (_, index, entry) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: InkWell(
                                onTap: () {
                                  final list = bloc.tasks.put(
                                    index,
                                    entry.copyWith(
                                      isSelected: !entry.isSelected,
                                      widget: BadgeWidget(
                                        icon: entry.icon,
                                        pointsValue: entry.points.toInt(),
                                        isSelected: !entry.isSelected,
                                      ),
                                    ),
                                  );
                                  bloc.addTasks(list);
                                },
                                child: MenuListItem(task: entry!),
                              ),
                            ),
                            if (bloc.tasks.length - 1 > index)
                              const Divider(
                                thickness: 2,
                                color: Colors.black12,
                                indent: 15,
                                endIndent: 15,
                              ),
                          ],
                        );
                      },
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
