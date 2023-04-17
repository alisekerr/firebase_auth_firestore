import 'package:bitely/core/constants/string/string_constants.dart';
import 'package:bitely/core/extension/context_extension.dart';
import 'package:bitely/view/workouts/model/workouts_model.dart';
import 'package:bitely/view/workouts/viewModel/workouts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/init/notifier/train_notifier.dart';
import '../../../core/widgets/appbar/custom_appbar_widget.dart';

class WorkoutsUpdateView extends StatelessWidget {
  const WorkoutsUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController time = TextEditingController();
    TextEditingController name = TextEditingController();
    var stateTrain = context.read<TrainNotifier>();
    var data = ModalRoute.of(context)?.settings.arguments as WorkoutsModel;

    return BaseView<WorkoutsViewModel>(
        viewModel: WorkoutsViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          // # Update edeceğimiz dataları dolduruyoruz
          time.text = data.trainTime.toString();
          name.text = data.trainType.toString();
        },
        onPageBuilder: (context, value) => Scaffold(
              appBar: CustomAppbarWidget(title: data.trainType),
              body: _buidBody(context, name, time, stateTrain, data),
            ));
  }

  Padding _buidBody(
      BuildContext context,
      TextEditingController name,
      TextEditingController time,
      TrainNotifier stateTrain,
      WorkoutsModel data) {
    return Padding(
      padding: context.paddingMedium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildChooseText(context),
          SizedBox(height: 5.h),
          _buildTrainNameTextField(name),
          SizedBox(height: 2.h),
          _buildTrainTimeTextField(time),
          SizedBox(height: 1.h),
          _buildTrainAddButton(stateTrain, time, name, data, context)
        ],
      ),
    );
  }

  SizedBox _buildTrainAddButton(
      TrainNotifier stateTrain,
      TextEditingController time,
      TextEditingController name,
      WorkoutsModel data,
      BuildContext context) {
    return SizedBox(
        width: 30.w,
        child: ElevatedButton(
          onPressed: () {
            stateTrain
                .updateTrain(
                    day: stateTrain.currentDay,
                    trainTime: int.tryParse(time.text),
                    trainType: name.text,
                    id: data.id)
                .whenComplete(() => Navigator.pop(context));
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(StringConstants.update),
        ));
  }

  TextField _buildTrainTimeTextField(TextEditingController time) {
    return TextField(
      controller: time,
      decoration: const InputDecoration(
        hintText: StringConstants.trainingTime,
      ),
    );
  }

  TextField _buildTrainNameTextField(TextEditingController name) {
    return TextField(
      controller: name,
      decoration: const InputDecoration(
        hintText: StringConstants.trainingName,
      ),
    );
  }

  Align _buildChooseText(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        StringConstants.chooseTrain,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
