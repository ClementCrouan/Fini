// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'app_colors.dart' as AppColors;

Widget customListTitle(
    {required String title,
    required int index,
    required Color colorTitle,
    onTap}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 15),
            Text(
              index.toString(),
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Avenir",
                color: AppColors.disabledColor2,
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Avenir",
                color: colorTitle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(
              width: 38,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(1),
                color: AppColors.disabledColor,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
