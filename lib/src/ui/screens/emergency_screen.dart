import 'package:flutter/material.dart';


class EmergencyScreen extends StatelessWidget {
static const routeName = '/emergency';
const EmergencyScreen({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Emergency')),
body: Padding(
padding: const EdgeInsets.all(20.0),
child: Column(
children: [
const SizedBox(height: 40),
Expanded(
child: Center(
child: ElevatedButton.icon(
style: ElevatedButton.styleFrom(
minimumSize: const Size.fromHeight(120),
backgroundColor: Colors.red,
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
),
onPressed: () {
// UI-only prototype: show dialog
showDialog(
context: context,
builder: (ctx) => AlertDialog(
title: const Text('Emergency'),
content: const Text('Would you like to call campus security?'),
actions: [
TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
ElevatedButton(onPressed: () => Navigator.pop(ctx), child: const Text('Call')),
],
),
);
},
icon: const Icon(Icons.warning, size: 40),
label: const Text('SOS', style: TextStyle(fontSize: 28)),
),
),
),
const SizedBox(height: 12),
Row(
children: [
Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Call Security'))),
const SizedBox(width: 12),
Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Call Health'))),
],
)
],
),
),
);
}
}
