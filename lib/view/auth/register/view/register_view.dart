import 'package:bitely/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/constants/string/string_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../../../core/init/notifier/auth_notifier.dart';
import '../../../../core/init/notifier/register_notifier.dart';
import '../viewModel/register_view_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
    var state = context.read<RegisterNotifier>();
    return BaseView<RegisterViewModel>(
        viewModel: RegisterViewModel(),
        onModelReady: (model) {
          model.setContext(context);
        },
        onPageBuilder: (context, value) => ModalProgressHUD(
              inAsyncCall: state.isLoading,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(StringConstants.createAccount),
                ),
                body:
                    _buildBody(context, formKey, name, email, password, state),
              ),
            ));
  }

  SafeArea _buildBody(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController name,
      TextEditingController email,
      TextEditingController password,
      RegisterNotifier state) {
    return SafeArea(
      child: Padding(
        padding: context.paddingMediumHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildForm(formKey, name, email, password),
            SizedBox(height: 10.h),
            _buildRegisterButton(
                formKey, name, email, password, context, state),
            _buildSignInTextButton(context),
          ],
        ),
      ),
    );
  }

  Column _buildSignInTextButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          StringConstants.alreadyAccount,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            StringConstants.signIn,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  ElevatedButton _buildRegisterButton(
      GlobalKey<FormState> formKey,
      TextEditingController name,
      TextEditingController email,
      TextEditingController password,
      BuildContext context,
      RegisterNotifier state) {
    return ElevatedButton(
        onPressed: () async {
          setState(() {
            state.changeLoading();
          });
          if (formKey.currentState!.validate()) {
            await context
                .read<AuthProvider>()
                .register(
                    email: email.text,
                    password: password.text,
                    userName: name.text)
                .whenComplete(() async {
              await context
                  .read<AuthProvider>()
                  .upgradeDisplayName(name.text)
                  .whenComplete(() {
                NavigationService.instance
                    .navigateToPageClear(path: NavigationConstants.HOME);
              });
            });
            setState(() {
              state.changeLoading();
            });
          }
        },
        style:
            ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 6.5.h)),
        child: Text(
          StringConstants.createAccount,
          style: Theme.of(context).textTheme.labelLarge,
        ));
  }

  Form _buildForm(GlobalKey<FormState> formKey, TextEditingController name,
      TextEditingController email, TextEditingController password) {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.5.h),
            _buildNameTextField(name),
            SizedBox(height: 3.h),
            _buildEmailTextField(email),
            SizedBox(height: 3.h),
            _buildPasswordTextField(password),
            SizedBox(height: 2.5.h),
          ],
        ));
  }

  TextFormField _buildPasswordTextField(TextEditingController password) {
    return TextFormField(
      controller: password,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: StringConstants.password,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 8) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }

  TextFormField _buildEmailTextField(TextEditingController email) {
    return TextFormField(
      controller: email,
      decoration: const InputDecoration(
        hintText: StringConstants.yourAccount,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  TextFormField _buildNameTextField(TextEditingController name) {
    return TextFormField(
      controller: name,
      decoration: const InputDecoration(
        hintText: StringConstants.nameHint,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }
}
