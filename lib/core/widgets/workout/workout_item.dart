import 'package:bitely/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color/color_constants.dart';

class WorkoutItem extends StatelessWidget {
  String trainType;
  int trainTime;
  final VoidCallback onPressed;
  final VoidCallback onDelete;
  WorkoutItem(
      {super.key,
      required this.trainType,
      required this.trainTime,
      required this.onPressed,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: context.paddingNormalOnlyBottom,
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstants.lightGrayColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: context.paddingNormalOnlyLeft,
                  child: Text(
                    "$trainType - $trainTime min",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Expanded(
                  child: GestureDetector(
                      onTap: onDelete,
                      child: const Icon(Icons.delete_outline))),
            ],
          ),
        ),
      ),
    );
  }
}
