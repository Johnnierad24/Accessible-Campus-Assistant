import 'package:flutter/material.dart';


class MapScreen extends StatelessWidget {
static const routeName = '/map';
const MapScreen({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Campus Map')),
body: Padding(
padding: const EdgeInsets.all(12.0),
child: Column(
children: [
Expanded(
child: Card(
child: Center(
child: Image.asset('assets/images/campus_map.png', fit: BoxFit.contain),
),
),
),
const SizedBox(height: 12),
Row(
children: [
Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.directions), label: const Text('Get Directions'))),
const SizedBox(width: 12),
Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.accessible), label: const Text('Accessible Routes'))),
],
)
],
),
),
);
}
}
