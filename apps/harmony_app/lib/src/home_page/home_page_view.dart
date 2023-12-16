import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/activity_list/activity_list_view.dart';
import 'package:harmony_app/src/home_page/home_page_bloc.dart';
import 'package:harmony_app/src/models/task.dart';
import 'package:harmony_app/src/progress_list/progress_list_view.dart';
import 'package:harmony_app/src/widgets/animated_scale.dart';
import 'package:harmony_app/src/widgets/dragging_list_item.dart';
import 'package:harmony_app/src/widgets/menu_list_item.dart';
import 'package:library_pkg/library_pkg.dart';

final _getIt = GetIt.instance;

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageBloc>(
      instance: HomePageBloc.new,
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: const [
              _MenuButton(),
            ],
          ),
          body: const SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _PageBody(),
          ),
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
    return Column(
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
                if (candidateItems.isEmpty) {
                  return const ScaleWidget();
                }
                return ScaleWidget(value: double.parse(candidateItems.first?.totalPriceCents.toString() ?? '0'));
              },
              onAccept: (item) {
                setState(() {
                  widget.bloc.setCompleted(item);
                });
              },
            ),
          ),
        ),
        AsyncBuilder<List<Task>>(
          stream: widget.bloc.tasksStream,
          retain: true,
          builder: (context, tasks) {
            return ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: tasks!.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
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
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          iconSize: 36,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        );
      },
      menuChildren: [
        MenuItemButton(
          leadingIcon: const Icon(Icons.info_outline),
          child: const Text('Activity List'),
          onPressed: () {
            Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) => const ActivityListView()));
          },
        ),
        MenuItemButton(
          leadingIcon: const Icon(Icons.feed_outlined),
          child: const Text('Progress'),
          onPressed: () {
            Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) => const ProgressListView()));
          },
        ),
      ],
    );
  }
}
