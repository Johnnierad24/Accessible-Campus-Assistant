import 'package:flutter/material.dart';
final _titleCtrl = TextEditingController();
final _timeCtrl = TextEditingController();
return AlertDialog(
title: const Text('Add Reminder'),
content: Column(
mainAxisSize: MainAxisSize.min,
children: [
TextField(controller: _titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
TextField(controller: _timeCtrl, decoration: const InputDecoration(labelText: 'Time')),
],
),
actions: [
TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
ElevatedButton(onPressed: () => Navigator.pop(ctx, {'title': _titleCtrl.text, 'time': _timeCtrl.text}), child: const Text('Add')),
],
);
},
);


if (result != null) {
setState(() {
_items.add(result);
});
}
}


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Reminders')),
body: ListView.builder(
padding: const EdgeInsets.all(12.0),
itemCount: _items.length,
itemBuilder: (ctx, i) => ReminderCard(title: _items[i]['title']!, time: _items[i]['time']!),
),
floatingActionButton: FloatingActionButton(onPressed: _addReminder, child: const Icon(Icons.add)),
);
}
}
