import 'package:color_picker/providers/auth_provider.dart';
import 'package:color_picker/screens/authentication/authentication.dart';
import 'package:color_picker/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_manager/window_manager.dart';

import './screens/root.dart';
import 'db/database_manager.dart';
import 'firebase_options.dart';
import 'lang/lang.dart';

import 'utils.dart' as utils;
import 'providers/theme_provider.dart';

part 'app_builder.dart';



/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
 await WidgetsFlutterBinding.ensureInitialized();

 if (kIsWeb) setPathUrlStrategy();

 if (isDesktop) {
   await WindowManager.instance.ensureInitialized();
   windowManager.waitUntilReadyToShow().then((_) async {
     await windowManager.setTitleBarStyle(TitleBarStyle.hidden,
         windowButtonVisibility: false);
     await windowManager.setSize(const Size(755, 545));
     await windowManager.setMinimumSize(const Size(755, 545));
     await windowManager.center();
     await windowManager.show();
     await windowManager.setPreventClose(true);
     await windowManager.setSkipTaskbar(false);
   });
 }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  utils.preferences = await SharedPreferences.getInstance();

  await DatabaseManager.startDatabase();
  await FavoriteColors.favorites();

 FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
 PlatformDispatcher.instance.onError = (error, stack) {
   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
   return true;
 };

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(
        utils.preferences.getString('theme') ?? ThemeMode.system.toString(),
      ),
      builder: (context, child) {
        final theme = ThemeProvider.of(context);
        return AppBuilder(
          key: GlobalKeys.appBuilderKey,
          child: MaterialApp(
            onGenerateTitle: (_) => Language.of(null).title,
            debugShowCheckedModeBanner: false,
            themeMode: theme.mode,
            darkTheme: ThemeProvider.darkTheme,
            theme: ThemeProvider.lightTheme,
            builder: (_, child) {
              child = ScrollConfiguration(
                child: ClipRect(child: child!),
                behavior: NoGlowBehavior(),
              );
              if (isDesktop) {
                return Scaffold(
                  body: Column(children: [
                    DragToMoveArea(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [Spacer(), WindowButtons()],
                      ),
                    ),
                    Expanded(
                      child: child,
                    ),
                  ]),
                );
              }
              return child;
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            home:
                _auth.currentUser?.uid == null ? AuthenticationPage() : Root(),
          ),
        );
      },
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) =>
      child;
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      width: 138,
      height: 39,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
