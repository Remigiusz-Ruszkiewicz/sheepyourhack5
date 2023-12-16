import 'package:flutter/material.dart';
import 'package:harmony_app/src/models/task.dart';

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    required this.dragKey,
    required this.task,
    super.key,
  });

  final GlobalKey dragKey;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 150,
          width: 150,
          child: Opacity(
            opacity: 0.85,
            child: Image(
              image: task.imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
