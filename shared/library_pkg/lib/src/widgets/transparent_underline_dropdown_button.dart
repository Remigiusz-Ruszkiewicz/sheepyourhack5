import 'package:flutter/material.dart';

class TransparentUnderlineDropdownButton<T> extends StatelessWidget {
  const TransparentUnderlineDropdownButton({
    required this.value,
    this.padding = EdgeInsets.zero,
    this.items,
    this.onChanged,
    super.key,
  });

  final T value;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: DropdownButton<T>(
        underline: const ColoredBox(
          color: Colors.transparent,
        ),
        focusColor: Colors.transparent,
        value: value,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
