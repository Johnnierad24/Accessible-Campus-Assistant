import 'package:flutter/material.dart';

class ReminderCard extends StatelessWidget {
  final String title;
  final String time;
  final bool done;
  final VoidCallback? onMarkDone;
  final VoidCallback? onSnooze;
  final VoidCallback? onDelete;

  const ReminderCard({
    super.key,
    required this.title,
    required this.time,
    this.done = false,
    this.onMarkDone,
    this.onSnooze,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          done ? Icons.check_circle : Icons.event_note,
          color: done ? Colors.green : null,
        ),
        title: Text(
          title,
          style: done
              ? const TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
        subtitle: Text(time),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'done':
                onMarkDone?.call();
                break;
              case 'snooze':
                onSnooze?.call();
                break;
              case 'delete':
                onDelete?.call();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'done', child: Text('Mark done')),
            const PopupMenuItem(value: 'snooze', child: Text('Snooze 5 min')),
            const PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
        ),
      ),
    );
  }
}
