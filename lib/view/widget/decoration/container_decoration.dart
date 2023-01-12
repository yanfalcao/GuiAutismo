import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';

ContainerDecoration({
  @required double radius,
  Color color,
  Offset offset
}) =>
    BoxDecoration(
        color: color ?? AppColors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
              color: AppColors.shadow,
              blurRadius: 6,
              offset: offset ?? Offset(1, 3)
          )
        ]
    );
