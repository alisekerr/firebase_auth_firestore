import 'package:bitely/core/init/mixin/auth_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../view/auth/login/model/user_model.dart';
import '../abstracts/i_auth_service.dart';

class AuthProvider with AuthMixin implements IAuthService {
  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  String? passwordTemp;
  UserModel? userInfo;

  // # User tipindeki nesenemizi UserModel e parse ettiğimiz fonksiyonumuz.

  UserModel getUser(User? user) {
    return UserModel(
        userId: user!.uid, userMail: user.email!, userName: user.displayName);
  }

  // # Kullanıcı state'ini dinlediğimiz fonksiyonumuz.
  @override
  Stream<UserModel?> get onAuthStateChange =>
      _authInstance.authStateChanges().map(getUser);

  // # Kullanıcı giriş fonksiyonumuz.
  @override
  Future<UserModel> signIn(
      {required String email, required String password}) async {
    var tempUser = await _authInstance.signInWithEmailAndPassword(
        email: email, password: password);
    debugPrint(tempUser.user?.displayName.toString());

    // # convertUser Mixin'den gelmektedir
    return convertUser(tempUser);
  }

  // # kullanıcı çıkış fonksiyonumuz.
  @override
  Future<void> signOut() async {
    await _authInstance.signOut();
  }

  // # Kullanıcı kayıt fonksiyonumuz.
  @override
  Future<UserModel> register(
      {required String email,
      required String password,
      required String? userName}) async {
    var tempUser = await _authInstance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // # Kullanıcıyı kayıt ettikten sonra displayName güncellemesi yapıyorum aynı kullanıcı üzerinde
    await tempUser.user?.updateDisplayName(userName);
    // # Kullanıcının güncellenen bilgilerini önce reload ile güncel datayı almak için reload çalıştırıyoruz ardından password 'e erişebilmek için nesne ataması yapıyoruz
    await tempUser.user?.reload();
    passwordTemp = password;
    return convertUser(tempUser);
  }

  // # Kullanıcı adı güncelleme için gerekli fonksiyonumuz kayıdın arkasından gelen.
  Future<void> upgradeDisplayName(String name) async {
    var tempUser = await _authInstance.signInWithEmailAndPassword(
      email: _authInstance.currentUser!.email!,
      password: passwordTemp!,
    );

    userInfo = convertUser(tempUser);
  }
}
