import 'package:bitely/core/widgets/auth/auth_error_widget.dart';
import 'package:bitely/core/widgets/auth/auth_widget_builder.dart';
import 'package:bitely/view/days/view/days_view.dart';
import 'package:flutter/material.dart';
import '../../../view/auth/login/view/login_view.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    return AuthWidgetBuilder(onPageBuilder: (context, snapshot) {
      return snapshot.connectionState == ConnectionState.active
          ? snapshot.hasData
              ? const DaysView()
              : const LoginView()
          : snapshot.connectionState == ConnectionState.waiting
              ? snapshot.hasData
                  ? const DaysView()
                  : const LoginView()
              : const AuthErrorWidget();
    });
    //);
  }
}
