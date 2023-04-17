import 'package:firebase_auth/firebase_auth.dart';

import '../../../view/auth/login/model/user_model.dart';

mixin AuthMixin {
  UserModel convertUser(UserCredential user) {
    return UserModel(
        userId: user.user!.uid,
        userMail: user.user!.email!,
        userName: user.user!.displayName);
  }
}
