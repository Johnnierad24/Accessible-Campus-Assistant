import 'package:flutter/material.dart';
import 'login_screen.dart';


class OnboardingScreen extends StatelessWidget {
static const routeName = '/onboarding';
const OnboardingScreen({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {
return Scaffold(
body: SafeArea(
child: Padding(
padding: const EdgeInsets.all(24.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
Expanded(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
// You can add Lottie animations here
Text('Welcome', style: Theme.of(context).textTheme.headline4),
const SizedBox(height: 8),
Text('Make campus life more accessible for everyone.'),
],
),
),
ElevatedButton(
onPressed: () => Navigator.pushReplacementNamed(context, LoginScreen.routeName),
child: const Padding(
padding: EdgeInsets.symmetric(vertical: 16.0),
child: Text('Get Started'),
),
),
TextButton(
onPressed: () => Navigator.pushReplacementNamed(context, LoginScreen.routeName),
child: const Text('Skip'),
)
],
),
),
),
);
}
}
