import 'package:collection/collection.dart';
import 'package:comprehensive_utils/comprehensive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:library_pkg/library_pkg.dart';

class EntityManagerView<T extends EntityManagerBloc> extends StatelessWidget {
  const EntityManagerView({required this.title, this.actions, this.leading, this.onTapItem, super.key});

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final ValueChanged<Entity>? onTapItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HarmonyAppBar(
        title: title,
        trailingWidgets: actions,
        leading: leading,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: _PageBody(GetIt.I.get<T>(), onTapItem),
      ),
    );
  }
}

class _PageBody extends StatelessWidget {
  const _PageBody(this.bloc, this.onItemTap);

  final EntityManagerBloc bloc;
  final ValueChanged<Entity>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return FluentListView<EntityListEntry>(
      retain: true,
      stream: bloc.entityEntriesStream,
      itemComparator: EqualityBy<EntityListEntry, Uri>((entry) => entry.entity.uri).equals,
      waiting: (_) => const Center(child: CircularProgressIndicator()),
      itemBuilder: (_, __, entry) => Card(
        child: ListTile(
          onTap: onItemTap?.apply(entry!.entity),
          title: Text(entry!.entity.name),
          leading: const Icon(Icons.feed_outlined),
          trailing: Checkbox(
            value: entry.isSelected,
            splashRadius: 24,
            onChanged: (_) => bloc.changeSelection(entry.entity),
          ),
        ),
      ),
    );
  }
}
