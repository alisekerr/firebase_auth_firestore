import 'package:bitely/view/splash/view/splash.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'core/constants/app/app_constants.dart';
import 'core/init/cache/locale_manager.dart';
import 'core/init/lang/language_manager.dart';
import 'core/init/navigation/navigation_router.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/notifier/app_provider.dart';
import 'core/init/notifier/theme_notifier.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  LocaleManager.prefrencesInit();

  runApp(
    MultiProvider(
      providers: [
        ...ApplicationProvider.instance.dependItems,
        ...ApplicationProvider.instance.uiChangesItems,
      ],
      child: EasyLocalization(
        supportedLocales: LanguageManager.instance.supportedLocales,
        path: ApplicationConstants.LANG_ASSET_PATH,
        startLocale: LanguageManager.instance.enLocale,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates, // Localization
          locale: LanguageManager.instance.enLocale,
          supportedLocales: LanguageManager.instance.supportedLocales,
          onGenerateRoute: NavigationRoute.instance.generateRoute,
          navigatorKey: NavigationService.instance.navigatorKey,
          theme: context.watch<ThemeNotifier>().currentTheme,
          home: const Splash()),
    );
  }
}
