import 'package:flutter/material.dart';
import 'home_screen.dart';


class LoginScreen extends StatefulWidget {
static const routeName = '/login';
const LoginScreen({Key? key}) : super(key: key);


@override
State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
final _formKey = GlobalKey<FormState>();
String _email = '';
String _password = '';


void _submit() {
if (_formKey.currentState!.validate()) {
_formKey.currentState!.save();
// For frontend prototype: go to home
Navigator.pushReplacementNamed(context, HomeScreen.routeName);
}
}


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Sign In')),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Form(
key: _formKey,
child: Column(
children: [
TextFormField(
decoration: const InputDecoration(labelText: 'Email'),
keyboardType: TextInputType.emailAddress,
validator: (v) => (v == null || v.isEmpty) ? 'Enter email' : null,
onSaved: (v) => _email = v ?? '',
),
TextFormField(
decoration: const InputDecoration(labelText: 'Password'),
obscureText: true,
validator: (v) => (v == null || v.length < 6) ? 'Min 6 chars' : null,
onSaved: (v) => _password = v ?? '',
),
const SizedBox(height: 16),
ElevatedButton(onPressed: _submit, child: const Text('Login')),
TextButton(onPressed: () {}, child: const Text('Forgot password?'))
],
),
),
),
);
}
}
