import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/enums/drawer_route.dart';
import 'package:harmony_app/src/home_page/home_page_bloc.dart';
import 'package:harmony_app/src/models/task.dart';
import 'package:harmony_app/src/widgets/animated_scale.dart';
import 'package:harmony_app/src/widgets/dragging_list_item.dart';
import 'package:harmony_app/src/widgets/harmony_page.dart';
import 'package:harmony_app/src/widgets/menu_list_item.dart';
import 'package:library_pkg/library_pkg.dart';

final _getIt = GetIt.instance;

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocProvider<HomePageBloc>(
      instance: HomePageBloc.new,
      child: HarmonyPage(
        drawerRoutes: [
          DrawerRoute.statistics,
          DrawerRoute.activityAssign,
          DrawerRoute.progress,
          DrawerRoute.rewards,
        ],
        body: Padding(
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
                final value = widget.bloc.libreLevel;
                if (candidateItems.isEmpty) {
                  return ScaleWidget(value: value == 0 ? 0 : value / 2);
                }
                return ScaleWidget(
                  value: (value + candidateItems.first!.points) / 2,
                );
              },
              onAccept: (item) {
                setState(() {
                  widget.bloc.setTaskCompleted(item);
                });
              },
            ),
          ),
        ),
        const ButtonWidget(),
        SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24),
          primary: false,
          child: AsyncBuilder<List<Task>>(
            stream: widget.bloc.tasksStream,
            retain: true,
            builder: (context, tasks) {
              return ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: tasks!.length,
                shrinkWrap: true,
                primary: true,
                separatorBuilder: (context, index) => const Divider(
                  thickness: 2,
                  color: Colors.black12,
                  indent: 15,
                  endIndent: 15,
                ),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Draggable<Task>(
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

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({super.key});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    late final AnimationController controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    late final Animation<double> scaleAnimation = Tween<double>(begin: 0.6, end: 1.2).animate(controller);
    late final Animation<double> fadeAnimation = Tween<double>(begin: 1, end: 0.2).animate(controller);

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: 50 * 1.5,
              height: 50 * 1.5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(119, 125, 242, 1),
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: 65 * 1.5,
              height: 65 * 1.5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(119, 125, 242, 1),
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: 80 * 1.5,
              height: 80 * 1.5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(119, 125, 242, 1),
              ),
            ),
          ),
        ),
        const Icon(
          Icons.home_work_outlined,
          size: 50,
          color: Colors.white,
        ),
      ],
    );
  }
}
