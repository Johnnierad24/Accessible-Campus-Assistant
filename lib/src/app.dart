import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'services/settings_service.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/onboarding_screen.dart';
import 'ui/screens/map_screen.dart';
import 'ui/screens/reminders_screen.dart';
import 'ui/screens/emergency_screen.dart';
import 'ui/screens/settings_screen.dart';


class RootApp extends StatelessWidget {
const RootApp({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {
return ScreenUtilInit(
designSize: const Size(390, 844),
builder: (context, child) {
final settings = Provider.of<SettingsService>(context);
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Accessible Campus Assistant',
theme: ThemeData(
brightness: settings.isDark ? Brightness.dark : Brightness.light,
textTheme: Theme.of(context).textTheme.apply(fontSizeFactor: settings.fontScale),
primarySwatch: Colors.indigo,
visualDensity: VisualDensity.adaptivePlatformDensity,
),
initialRoute: SplashScreen.routeName,
routes: {
SplashScreen.routeName: (_) => const SplashScreen(),
OnboardingScreen.routeName: (_) => const OnboardingScreen(),
LoginScreen.routeName: (_) => const LoginScreen(),
HomeScreen.routeName: (_) => const HomeScreen(),
MapScreen.routeName: (_) => const MapScreen(),
RemindersScreen.routeName: (_) => const RemindersScreen(),
EmergencyScreen.routeName: (_) => const EmergencyScreen(),
SettingsScreen.routeName: (_) => const SettingsScreen(),
},
);
},
);
}
}
