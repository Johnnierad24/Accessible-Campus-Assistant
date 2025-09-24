import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'reminders_screen.dart';
import 'emergency_screen.dart';
import 'settings_screen.dart';


class HomeScreen extends StatelessWidget {
static const routeName = '/home';
const HomeScreen({Key? key}) : super(key: key);


Widget _buildTile(BuildContext context, String title, IconData icon, VoidCallback onTap) {
return Card(
margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
child: ListTile(
leading: Icon(icon, size: 32),
title: Text(title, style: Theme.of(context).textTheme.subtitle1),
trailing: const Icon(Icons.chevron_right),
onTap: onTap,
),
);
}


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Dashboard')),
body: ListView(
padding: const EdgeInsets.symmetric(vertical: 12),
children: [
const SizedBox(height: 8),
_buildTile(context, 'Campus Map', Icons.map, () => Navigator.pushNamed(context, MapScreen.routeName)),
_buildTile(context, 'Reminders', Icons.notifications_active, () => Navigator.pushNamed(context, RemindersScreen.routeName)),
_buildTile(context, 'Emergency', Icons.warning, () => Navigator.pushNamed(context, EmergencyScreen.routeName)),
_buildTile(context, 'Settings', Icons.settings, () => Navigator.pushNamed(context, SettingsScreen.routeName)),
],
),
);
}
}
