import 'package:bitely/core/widgets/auth/auth_widget.dart';
import 'package:bitely/view/auth/login/view/login_view.dart';
import 'package:bitely/view/auth/register/view/register_view.dart';
import 'package:bitely/view/days/view/days_view.dart';
import 'package:bitely/view/workouts/view/workouts_update_view.dart';
import 'package:bitely/view/workouts/view/workouts_view.dart';
import 'package:flutter/material.dart';

import '../../../view/workouts/view/workouts_add_view.dart';
import '../../constants/navigation/navigation_constants.dart';

class NavigationRoute {
  static NavigationRoute? _instance;
  static NavigationRoute get instance {
    _instance ??= NavigationRoute._init();
    return _instance!;
  }

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.AUTH:
        return normalNavigate(const AuthWidget(), args.arguments);
      case NavigationConstants.LOGIN:
        return normalNavigate(const LoginView(), args.arguments);
      case NavigationConstants.REGISTER:
        return normalNavigate(const RegisterView(), args.arguments);
      case NavigationConstants.HOME:
        return normalNavigate(const DaysView(), args.arguments);
      case NavigationConstants.WORKOUTS:
        return normalNavigate(const WorkoutsView(), args.arguments);
      case NavigationConstants.WORKOUTS_ADD:
        return normalNavigate(const WorkoutsAddView(), args.arguments);
      case NavigationConstants.WORKOUTS_UPDATE:
        return normalNavigate(const WorkoutsUpdateView(), args.arguments);
    }
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Text("NOT FOUND"),
      ),
    );
  }
}

MaterialPageRoute normalNavigate(Widget widget, Object? obj) {
  return MaterialPageRoute(
      builder: (context) => widget, settings: RouteSettings(arguments: obj));
}
