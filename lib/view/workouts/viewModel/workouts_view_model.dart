import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/model/base_view_model.dart';

part 'workouts_view_model.g.dart';

class WorkoutsViewModel = _WorkoutsViewModelBase with _$WorkoutsViewModel;

abstract class _WorkoutsViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
