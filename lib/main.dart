import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_localization/localizations.dart';
import 'package:smart_home_iot/data/theme/my_theme.dart';
import 'package:smart_home_iot/provider/auth_provider.dart';
import 'package:smart_home_iot/provider/events_provider.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/provider/theme_provider.dart';
import 'package:smart_home_iot/provider/user_provider.dart';
import 'package:smart_home_iot/router/app_router.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';
import 'package:smart_home_iot/views/splash/splash.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.dark
    ),
  );
  runApp(const MyApp());
  FirebaseApp firebaseApp = await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ListRoomProvider(),
        ),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => EventsProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
          initialRoute: RouteName.splash,
          onGenerateRoute: RouterRoot.onGenerateRoute,
          themeMode: context.watch<ThemeProvider>().themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          debugShowCheckedModeBanner: false,
          supportedLocales: const [
            Locale('vi', 'VN'),
            Locale('en', 'US'),
          ],
          locale: Provider.of<ThemeProvider>(context).locale,
          // locale: context.watch<ThemeProvider>().getLocale(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          home: const SplashPageScreen(),
        );
      },
    );
  }
}
