// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gharbeti_ui/shared/app_prefrence.dart';
import 'package:gharbeti_ui/shared/push_notification_controller.dart';
import 'package:gharbeti_ui/shared/routes.dart';
import 'package:gharbeti_ui/splash_screen/intro_screen.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

const String testPublicKey = 'test_public_key_dc74e0fd57cb46cd93832aee0a507256';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(
      FirebaseNotification.firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: testPublicKey,
      enabledDebugging: true,
      builder: (context, navKey) {
        return ChangeNotifierProvider<AppPreferenceNotifier>(
          create: (_) => AppPreferenceNotifier(),
          builder: (context, _) {
            return Consumer<AppPreferenceNotifier>(
              builder: (context, appPreference, _) {
                return MaterialApp(
                  title: 'Khalti Payment Gateway',
                  initialRoute: SplashScreen.route,
                  supportedLocales: const [
                    Locale('en', 'US'),
                    Locale('ne', 'NP'),
                  ],
                  locale: appPreference.locale,
                  localizationsDelegates: const [
                    KhaltiLocalizations.delegate,
                  ],
                  theme: ThemeData(
                    brightness: appPreference.brightness,
                    primarySwatch: Colors.blue,
                    pageTransitionsTheme: const PageTransitionsTheme(
                      builders: {
                        TargetPlatform.android: ZoomPageTransitionsBuilder(),
                      },
                    ),
                  ),
                  debugShowCheckedModeBanner: false,
                  navigatorKey: navKey,
                  routes: Routes.routes,
                  onGenerateInitialRoutes: (route) {
                    // Only used for handling response from KPG in Flutter Web.
                    if (route.startsWith('/kpg/')) {
                      final uri = Uri.parse('https://khalti.com$route');
                      return [
                        MaterialPageRoute(
                          builder: (context) => SplashScreen(),
                        ),
                      ];
                    }
                    return Navigator.defaultGenerateInitialRoutes(
                      navKey.currentState!,
                      route,
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
    return MaterialApp(
        // navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        //home: SplashScreen(),
        initialRoute: SplashScreen.route,
        routes: Routes.routes);
  }
}
