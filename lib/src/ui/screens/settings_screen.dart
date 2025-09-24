import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/settings_service.dart';


class SettingsScreen extends StatelessWidget {
static const routeName = '/settings';
const SettingsScreen({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {
final settings = Provider.of<SettingsService>(context);
return Scaffold(
appBar: AppBar(title: const Text('Settings')),
body: Padding(
padding: const EdgeInsets.all(12.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
SwitchListTile(
title: const Text('Dark Mode'),
value: settings.isDark,
onChanged: (v) => settings.toggleDark(v),
),
const SizedBox(height: 12),
Text('Font Size', style: Theme.of(context).textTheme.subtitle1),
const SizedBox(height: 8),
Row(
children: [
ElevatedButton(onPressed: () => settings.setFontScale(0.9), child: const Text('Small')),
const SizedBox(width: 8),
ElevatedButton(onPressed: () => settings.setFontScale(1.0), child: const Text('Normal')),
const SizedBox(width: 8),
ElevatedButton(onPressed: () => settings.setFontScale(1.2), child: const Text('Large')),
],
),
const SizedBox(height: 20),
Text('Accessibility', style: Theme.of(context).textTheme.subtitle1),
const SizedBox(height: 8),
ListTile(
leading: const Icon(Icons.record_voice_over),
title: const Text('Voice Commands (Placeholder)'),
trailing: const Icon(Icons.chevron_right),
onTap: () {},
),
],
),
),
);
}
}
