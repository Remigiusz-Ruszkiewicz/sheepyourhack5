/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:flutter/material.dart';

class PageBlueprint extends StatelessWidget {
  const PageBlueprint({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox.expand(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
