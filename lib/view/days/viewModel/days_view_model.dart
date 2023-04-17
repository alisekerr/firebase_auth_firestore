import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/model/base_view_model.dart';

part 'days_view_model.g.dart';

class DaysViewModel = _DaysViewModelBase with _$DaysViewModel;

abstract class _DaysViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
