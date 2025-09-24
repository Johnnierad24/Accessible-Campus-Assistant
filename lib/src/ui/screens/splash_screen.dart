import 'package:flutter/material.dart';
import 'dart:async';
import 'onboarding_screen.dart';


class SplashScreen extends StatefulWidget {
static const routeName = '/';
const SplashScreen({Key? key}) : super(key: key);


@override
State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
super.initState();
Timer(const Duration(seconds: 2), () {
Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
});
}


@override
Widget build(BuildContext context) {
return Scaffold(
body: Center(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
// Add your splash image under assets/images/splash.png
Image.asset('assets/images/splash.png', width: 140),
const SizedBox(height: 12),
Text('Accessible Campus', style: Theme.of(context).textTheme.headline6),
],
),
),
);
}
}
