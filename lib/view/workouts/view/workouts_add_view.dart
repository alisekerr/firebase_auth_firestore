import 'package:bitely/core/constants/string/string_constants.dart';
import 'package:bitely/core/extension/context_extension.dart';
import 'package:bitely/core/widgets/appbar/custom_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/init/notifier/auth_notifier.dart';
import '../../../core/init/notifier/train_notifier.dart';

class WorkoutsAddView extends StatelessWidget {
  const WorkoutsAddView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController time = TextEditingController();
    TextEditingController name = TextEditingController();
    var stateTrain = context.read<TrainNotifier>();
    return Scaffold(
      appBar: CustomAppbarWidget(title: StringConstants.trainingAdd),
      body: Padding(
        padding: context.paddingMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildChooseText(context),
            SizedBox(height: 5.h),
            _buildTextFieldName(name),
            SizedBox(height: 2.h),
            _buildTextFieldTime(time),
            SizedBox(height: 1.h),
            _buildTrainAddButton(stateTrain, time, name, context)
          ],
        ),
      ),
    );
  }

  SizedBox _buildTrainAddButton(
      TrainNotifier stateTrain,
      TextEditingController time,
      TextEditingController name,
      BuildContext context) {
    return SizedBox(
        width: 30.w,
        child: ElevatedButton(
          onPressed: () {
            stateTrain
                .postTrain(
                    day: stateTrain.currentDay,
                    trainTime: int.tryParse(time.text),
                    trainType: name.text)
                .whenComplete(() async {
              Navigator.pop(context);
            });
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(StringConstants.add),
        ));
  }

  TextField _buildTextFieldTime(TextEditingController time) {
    return TextField(
      controller: time,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: StringConstants.trainingTime,
      ),
    );
  }

  TextField _buildTextFieldName(TextEditingController name) {
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
