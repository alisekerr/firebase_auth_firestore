import 'package:bitely/core/init/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view/auth/login/model/user_model.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({super.key, required this.onPageBuilder}) : super();
  final Widget Function(
      BuildContext context, AsyncSnapshot<UserModel?> snapshot) onPageBuilder;
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context, listen: false);
    return StreamBuilder<UserModel?>(
      stream: authService.onAuthStateChange,
      builder: (context, AsyncSnapshot<UserModel?> snapshot) {
        final userData = snapshot.data;
        if (userData != null) {
          authService.userInfo = userData;
          return MultiProvider(
            providers: [
              Provider.value(value: userData),
            ],
            child: onPageBuilder(context, snapshot),
          );
        }

        return onPageBuilder(context, snapshot);
      },
    );
  }
}
