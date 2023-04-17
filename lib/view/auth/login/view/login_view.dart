import 'package:bitely/core/constants/color/color_constants.dart';
import 'package:bitely/core/constants/navigation/navigation_constants.dart';
import 'package:bitely/core/constants/string/string_constants.dart';
import 'package:bitely/core/extension/context_extension.dart';
import 'package:bitely/core/init/navigation/navigation_service.dart';
import 'package:bitely/core/init/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/constants/image/image_constants.dart';
import '../viewModel/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return BaseView<LoginViewModel>(
      viewModel: LoginViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (context, value) => Scaffold(
        appBar: _buildAppbar(context),
        body: _buildBody(context, email, password),
      ),
    );
  }

  SafeArea _buildBody(BuildContext context, TextEditingController email,
      TextEditingController password) {
    return SafeArea(
      child: Padding(
        padding: context.paddingMediumHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLoginText(context),
                SizedBox(height: 6.5.h),
                _buildAccountTextField(email),
                SizedBox(height: 3.h),
                _buildPasswordTextFiled(password),
                SizedBox(height: 2.5.h),
                _buildSignUporButtons(context),
              ],
            ),
            const SizedBox.shrink(),
            _buildSignInButton(context, email, password),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  TextField _buildPasswordTextFiled(TextEditingController password) {
    return TextField(
      controller: password,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: StringConstants.password,
      ),
    );
  }

  TextField _buildAccountTextField(TextEditingController email) {
    return TextField(
      controller: email,
      decoration: const InputDecoration(
        hintText: StringConstants.yourAccount,
      ),
    );
  }

  Text _buildLoginText(BuildContext context) {
    return Text(
      StringConstants.loginInTo,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  ElevatedButton _buildSignInButton(BuildContext context,
      TextEditingController email, TextEditingController password) {
    var tempError = "";
    return ElevatedButton(
        onPressed: () async {
          // # Geçici olarak form validate kullanmamak için yapılmış kullanıcı giriş kontrol
          context
              .read<AuthProvider>()
              .signIn(email: email.text, password: password.text)
              // ignore: invalid_return_type_for_catch_error, body_might_complete_normally_catch_error
              .catchError((e) {
            tempError = e.toString();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }).whenComplete(() {
            if (tempError == "") {
              NavigationService.instance
                  .navigateToPageClear(path: NavigationConstants.AUTH);
            }
            {
              tempError = "";
            }
          });
        },
        style:
            ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 6.5.h)),
        child: Text(
          StringConstants.signIn,
          style: Theme.of(context).textTheme.labelLarge,
        ));
  }

  Row _buildSignUporButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                NavigationService.instance
                    .navigateToPage(path: NavigationConstants.REGISTER);
              },
              child: Text(StringConstants.signUp,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(StringConstants.or,
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        Row(children: [
          ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              padding: context.paddingNormal,
              backgroundColor: ColorConstants.semiGrayColor.withOpacity(0.3),
              elevation: 0,
              shape: const CircleBorder(),
            ),
            child: Image.asset(
              ImageConstants.instance.facebook,
              scale: 0.9,
            ),
          ),
          ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              padding: context.paddingNormal,
              backgroundColor: ColorConstants.semiGrayColor.withOpacity(0.3),
              elevation: 0,
              shape: const CircleBorder(),
            ),
            child: Image.asset(
              ImageConstants.instance.google,
              scale: 0.9,
            ),
          ),
          ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              padding: context.paddingNormal,
              backgroundColor: ColorConstants.semiGrayColor.withOpacity(0.3),
              elevation: 0,
              shape: const CircleBorder(),
            ),
            child: Image.asset(
              ImageConstants.instance.apple,
              scale: 0.9,
            ),
          ),
        ]),
      ],
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.whiteColor,
      toolbarHeight: 7.h,
      elevation: 0,
      leadingWidth: 100.w,
      leading: Padding(
        padding: context.paddingMediumHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Text(
              StringConstants.hi,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
