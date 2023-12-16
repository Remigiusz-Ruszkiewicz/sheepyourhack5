import 'package:flutter/material.dart';
import 'package:harmony_app/src/models/task.dart';

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    required this.task,
    this.isDepressed = false,
    super.key,
  });

  final bool isDepressed;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: SizedBox(
                height: 60,
                width: 90,
                child: task.widget,
              ),
            ),
          ),
          Expanded(
            child: Text(
              task.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
