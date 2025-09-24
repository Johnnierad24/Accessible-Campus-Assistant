import 'package:flutter/material.dart';


class ReminderCard extends StatelessWidget {
final String title;
final String time;
const ReminderCard({Key? key, required this.title, required this.time}) : super(key: key);


@override
Widget build(BuildContext context) {
return Card(
margin: const EdgeInsets.symmetric(vertical: 8),
child: ListTile(
leading: const Icon(Icons.event_note),
title: Text(title),
subtitle: Text(time),
trailing: IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
),
);
}
}
