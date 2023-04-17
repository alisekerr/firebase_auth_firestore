import 'package:bitely/core/constants/string/string_constants.dart';
import 'package:bitely/core/init/notifier/splash_notifier.dart';
import 'package:bitely/view/splash/viewmodel/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/navigation/navigation_service.dart';

class Splash extends StatelessWidget {
  const Splash({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
        viewModel: SplashViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          Future.microtask(() async {
            context.read<SplashNotifier>().splashOpacityUp();
            await Future.delayed(const Duration(seconds: 3)).whenComplete(() {
              NavigationService.instance.navigateToPageClear(
                path: NavigationConstants.AUTH,
              );
            });
          });
        },
        onPageBuilder: (context, value) => Scaffold(
              body: AnimatedOpacity(
                opacity: context.watch<SplashNotifier>().imageOpacity,
                duration: const Duration(seconds: 2),
                child: Center(
                  child: Text(StringConstants.appName,
                      style: Theme.of(context).textTheme.headlineMedium),
                ),
              ),
            ));
  }
}
