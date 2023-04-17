import 'package:bitely/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color/color_constants.dart';

class DaysItem extends StatelessWidget {
  String day;
  final VoidCallback onPress;
  DaysItem({super.key, required this.day, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: context.paddingNormalOnlyBottom,
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstants.lightGrayColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: context.paddingNormalHorizontal,
                child: Text(
                  day,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )),
        ),
      ),
    );
  }
}
