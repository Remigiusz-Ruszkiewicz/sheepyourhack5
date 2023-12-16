import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({required this.icon, required this.pointsValue, this.isSelected = false, super.key});

  final IconData icon;
  final int pointsValue;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Badge(
      largeSize: 50,
      smallSize: 50,
      backgroundColor: Colors.transparent,
      textColor: Colors.black,
      alignment: Alignment.topRight,
      padding: const EdgeInsets.only(left: 12, bottom: 30),
      label: Text(
        '+ $pointsValue  ',
        style: const TextStyle(fontSize: 15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(119, 125, 242, 1),
        ),
        child: Icon(isSelected ? Icons.check : icon),
      ),
    );
  }
}
