import 'package:async_builder/async_builder.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/activity_list/activity_list_view.dart';
import 'package:harmony_app/src/home_page/home_page_bloc.dart';
import 'package:harmony_app/src/models/task.dart';
import 'package:harmony_app/src/progress_list/progress_list_view.dart';
import 'package:harmony_app/src/widgets/animated_scale.dart';
import 'package:harmony_app/src/widgets/dragging_list_item.dart';
import 'package:harmony_app/src/widgets/menu_list_item.dart';
import 'package:library_pkg/library_pkg.dart';
import 'package:localization_pkg/localization_pkg.dart';

final _getIt = GetIt.instance;

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageBloc>(
      instance: HomePageBloc.new,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Builder(
              builder: (context) => DrawerButton(
                style: IconButton.styleFrom(iconSize: 36, foregroundColor: Colors.black),
                onPressed: () => Scaffold.maybeOf(context)?.openEndDrawer(),
              ),
            ),
          ],
        ),
        endDrawer: Drawer(
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: const Icon(
                    Icons.show_chart,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Statystyki',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.task,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Przydziel zadania',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) => const ActivityListView()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.task_alt,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Postępy',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.card_giftcard,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Nagrody',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) => const ProgressListView()));
                  },
                ),
              ],
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _PageBody(),
        ),
      ),
    );
  }
}

class _PageBody extends StatelessWidget {
  const _PageBody();

  @override
  Widget build(BuildContext context) {
    final bloc = _getIt.get<HomePageBloc>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AsyncBuilder<String>(
            stream: bloc.timeStream,
            retain: true,
            initial: '',
            builder: (_, time) => Text(
              time!,
              style: const TextStyle(
                fontSize: 36,
                color: Colors.black,
              ),
            ),
          ),
          AsyncBuilder<String>(
            stream: bloc.hintTextStream,
            retain: true,
            builder: (_, hint) => Text(
              hint!,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          _DraggableList(bloc),
        ],
      ),
    );
  }
}

class _DraggableList extends StatefulWidget {
  const _DraggableList(this.bloc);

  final HomePageBloc bloc;

  @override
  State<_DraggableList> createState() => _DraggableListState();
}

class _DraggableListState extends State<_DraggableList> with TickerProviderStateMixin {
  final GlobalKey _draggableKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 20,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: DragTarget<Task>(
              builder: (context, candidateItems, rejectedItems) {
                return const ScaleWidget();
              },
              onAccept: (item) {
                setState(() {
                  widget.bloc.setCompleted(item);
                });
              },
            ),
          ),
        ),
        SingleChildScrollView(
          primary: true,
          child: AsyncBuilder<List<Task>>(
            stream: widget.bloc.tasksStream,
            retain: true,
            builder: (context, tasks) {
              return ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: tasks!.length,
                shrinkWrap: true,
                primary: true,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return LongPressDraggable<Task>(
                    data: task,
                    dragAnchorStrategy: pointerDragAnchorStrategy,
                    feedback: DraggingListItem(
                      dragKey: _draggableKey,
                      task: task,
                    ),
                    child: MenuListItem(task: task),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
