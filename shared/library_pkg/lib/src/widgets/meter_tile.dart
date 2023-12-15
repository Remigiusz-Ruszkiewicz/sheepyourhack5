/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:flutter/material.dart';

@immutable
class MeterTile extends StatelessWidget {
  const MeterTile({
    required this.name,
    required this.information,
    super.key,
    this.onTap,
  });

  final String name;
  final String information;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: onTap,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Wrap(
              spacing: 10,
              alignment: WrapAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.laptop_chromebook_outlined,
                ),
                Text('$name : $information', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
