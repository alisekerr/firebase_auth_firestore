import 'package:bitely/core/constants/string/string_constants.dart';
import 'package:bitely/core/extension/context_extension.dart';
import 'package:bitely/core/init/navigation/navigation_service.dart';
import 'package:bitely/core/init/notifier/train_notifier.dart';
import 'package:bitely/core/widgets/appbar/custom_appbar_widget.dart';
import 'package:bitely/view/workouts/model/workouts_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/notifier/auth_notifier.dart';
import '../../../core/widgets/workout/workout_item.dart';

class WorkoutsView extends StatefulWidget {
  const WorkoutsView({super.key});

  @override
  State<WorkoutsView> createState() => _WorkoutsViewState();
}

class _WorkoutsViewState extends State<WorkoutsView> {
  @override
  Widget build(BuildContext context) {
    var state = context.read<AuthProvider>();
    var stateTrain = context.read<TrainNotifier>();
    return Scaffold(
      appBar: CustomAppbarWidget(
        title: StringConstants.workouts,
      ),
      body: _buildBody(context, state, stateTrain),
      floatingActionButton: _buildFloatActionButton(),
    );
  }

  FloatingActionButton _buildFloatActionButton() {
    return FloatingActionButton(
      child: Icon(
        Icons.add,
        size: 25.sp,
      ),
      onPressed: () {
        NavigationService.instance
            .navigateToPage(path: NavigationConstants.WORKOUTS_ADD);
      },
    );
  }

  Padding _buildBody(
      BuildContext context, AuthProvider state, TrainNotifier stateTrain) {
    return Padding(
      padding: context.paddingMedium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPreText(state, context),
          _buildWorkoutsList(context, stateTrain)
        ],
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
          StringConstants.selectWorkout,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.labelSmall,
        )
      ],
    );
  }

  FutureBuilder<List<WorkoutsModel>> _buildWorkoutsList(
      BuildContext context, TrainNotifier stateTrain) {
    return FutureBuilder(
      future: context.read<TrainNotifier>().getDaysData(stateTrain.currentDay),
      builder: (context, snapshot) => Consumer<TrainNotifier>(
        builder: (context, value, child) => SizedBox(
          width: double.infinity,
          height: 70.h,
          child: ListView.builder(
            itemCount: stateTrain.trainList.length,
            itemExtent: 9.h,
            itemBuilder: (context, index) {
              return WorkoutItem(
                trainType: stateTrain.trainList[index].trainType,
                trainTime: stateTrain.trainList[index].trainTime,
                onPressed: () {
                  NavigationService.instance.navigateToPage(
                      path: NavigationConstants.WORKOUTS_UPDATE,
                      data: stateTrain.trainList[index]);
                },
                onDelete: () {
                  stateTrain.deleteTrain(
                      stateTrain.currentDay, value.trainList[index].id);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
