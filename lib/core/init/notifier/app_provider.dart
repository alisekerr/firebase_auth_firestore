import 'package:bitely/core/init/abstracts/i_auth_service.dart';
import 'package:bitely/core/init/notifier/auth_notifier.dart';
import 'package:bitely/core/init/notifier/register_notifier.dart';
import 'package:bitely/core/init/notifier/splash_notifier.dart';
import 'package:bitely/core/init/notifier/train_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../navigation/navigation_service.dart';
import 'theme_notifier.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;
  static ApplicationProvider get instance {
    _instance ??= ApplicationProvider._init();
    return _instance!;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
    ),
    ChangeNotifierProvider(
      create: (context) => RegisterNotifier(),
    ),
    Provider.value(value: AuthProvider()),
    ChangeNotifierProvider<TrainNotifier>(
      create: (context) => TrainNotifier(),
    ),
    Provider.value(value: NavigationService.instance)
  ];
  List<SingleChildWidget> uiChangesItems = [
    ChangeNotifierProvider(
      create: (context) => SplashNotifier(),
    ),
  ];
}
