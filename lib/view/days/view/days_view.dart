import 'package:bitely/core/constants/color/color_constants.dart';
import 'package:bitely/core/constants/string/string_constants.dart';
import 'package:bitely/core/extension/context_extension.dart';
import 'package:bitely/core/init/navigation/navigation_service.dart';
import 'package:bitely/core/widgets/appbar/custom_appbar_widget.dart';
import 'package:bitely/core/widgets/days/days_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/notifier/auth_notifier.dart';
import '../../../core/init/notifier/train_notifier.dart';

class DaysView extends StatelessWidget {
  const DaysView({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.read<AuthProvider>();
    var trainState = context.read<TrainNotifier>();

    return Scaffold(
        appBar: CustomAppbarWidget(title: "Days"),
        body: _buildBody(context, state, trainState));
  }

  Padding _buildBody(
      BuildContext context, AuthProvider state, TrainNotifier trainState) {
    return Padding(
      padding: context.paddingMedium,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildPreText(state, context), _buildDayList(trainState)],
      ),
    );
  }

  SizedBox _buildDayList(TrainNotifier trainState) {
    return SizedBox(
      width: double.infinity,
      height: 70.h,
      child: ListView.builder(
        itemCount: trainState.days.length,
        itemExtent: 9.h,
        itemBuilder: (context, index) {
          return DaysItem(
            day: trainState.days[index],
            onPress: () {
              trainState.currentDay = trainState.days[index];
              trainState.getDaysData(trainState.days[index]);
              NavigationService.instance
                  .navigateToPage(path: NavigationConstants.WORKOUTS);
            },
          );
        },
      ),
    );
  }

  Column _buildPreText(AuthProvider state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${StringConstants.hello},${state.userInfo?.userName}",
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          StringConstants.chooseDay,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.labelSmall,
        )
      ],
    );
  }
}
