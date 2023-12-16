import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/activity_list/activity_list_view.dart';
import 'package:harmony_app/src/home_page/home_page_bloc.dart';
import 'package:harmony_app/src/progress_list/progress_list_view.dart';
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
          leading: const _MenuButton(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MaterialButton(
                child: Text('ActivityListView'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ActivityListView()),
                ),
              ),
              MaterialButton(
                child: Text('ProgressListView'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProgressListView()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton();

  @override
  Widget build(BuildContext context) {
    final bloc = _getIt.get<HomePageBloc>();
    return MenuAnchor(
      builder: (context, controller, child) {
        return FilledButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: const Icon(Icons.menu), // Text(LocaleKeys.options.tr()),
        );
      },
      menuChildren: [
        MenuItemButton(
          leadingIcon: const Icon(Icons.info_outline),
          child: Text(LocaleKeys.about.tr()),
          onPressed: () async {},
        ),
        MenuItemButton(
          leadingIcon: const Icon(Icons.feed_outlined),
          child: Text(LocaleKeys.logs.tr()),
          onPressed: () {},
        ),
        MenuItemButton(
          leadingIcon: const Icon(Icons.settings),
          child: Text(LocaleKeys.settings.tr()),
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(LocaleKeys.settings.tr()),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox.shrink(),
                    ],
                  ),
                  actionsPadding: const EdgeInsets.only(right: 16, bottom: 16),
                  actions: [
                    OutlinedButton(
                      onPressed: Navigator.of(context).pop,
                      child: const Icon(Icons.close),
                    ),
                  ],
                );
              },
            );
          },
        ),
        MenuItemButton(
          leadingIcon: const Icon(Icons.help_outline),
          child: Text(LocaleKeys.help.tr()),
          onPressed: () {},
        ),
      ],
    );
  }
}
