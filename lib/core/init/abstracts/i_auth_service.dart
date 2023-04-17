import '../../../view/auth/login/model/user_model.dart';

abstract class IAuthService {
  Future<UserModel> signIn({required String email, required String password});
  Future<UserModel> register(
      {required String email,
      required String password,
      required String? userName});
  Future<void> signOut();

  Stream<UserModel?> get onAuthStateChange;
}
