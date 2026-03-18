import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/reminders_service.dart';
import '../../services/voice_service.dart';
import '../widgets/reminder_card.dart';

class RemindersScreen extends StatefulWidget {
  static const routeName = '/reminders';
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  Future<void> _addReminder(BuildContext context) async {
    final titleCtrl = TextEditingController();
    final timeCtrl = TextEditingController();
    final reminders = context.read<RemindersService>();

    final result = await showDialog<ReminderItem?>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Reminder'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'e.g. Pick up library book',
              ),
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: timeCtrl,
              decoration: const InputDecoration(
                  labelText: 'Time', hintText: 'Today 4:30 PM'),
              onSubmitted: (_) => Navigator.of(ctx).pop(
                ReminderItem(
                    title: titleCtrl.text.trim(), time: timeCtrl.text.trim()),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(
              ctx,
              ReminderItem(
                  title: titleCtrl.text.trim(), time: timeCtrl.text.trim()),
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && result.title.isNotEmpty) {
      await reminders.addReminder(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final remindersService = context.watch<RemindersService>();
    final items = remindersService.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        actions: [
          IconButton(
            tooltip: 'Voice add',
            onPressed: VoiceService.instance.isAvailable
                ? () async {
                    await VoiceService.instance.listenForText((text) async {
                      final reminder = ReminderItem(
                        title: text,
                        time: 'Voice note',
                      );
                      await remindersService.addReminder(reminder);
                      await VoiceService.instance
                          .speak('Added reminder for $text');
                    });
                  }
                : null,
            icon: const Icon(Icons.mic),
          ),
        ],
      ),
      body: !remindersService.isLoaded
          ? const Center(child: CircularProgressIndicator())
          : items.isEmpty
              ? const Center(child: Text('No reminders yet. Tap + to add one.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(12.0),
                  itemCount: items.length,
                  itemBuilder: (ctx, i) => Dismissible(
                    key: ValueKey('${items[i].title}-$i'),
                    background: Container(
                      color: Colors.red.shade400,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red.shade400,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) =>
                        context.read<RemindersService>().removeAt(i),
                    child: ReminderCard(
                      title: items[i].title,
                      time: items[i].time,
                      done: items[i].done,
                      onMarkDone: () => remindersService.markDone(items[i]),
                      onSnooze: () => remindersService.snooze(items[i],
                          duration: const Duration(minutes: 5)),
                      onDelete: () => remindersService.removeAt(i),
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addReminder(context),
        tooltip: 'Add reminder',
        child: const Icon(Icons.add),
      ),
    );
  }
}
