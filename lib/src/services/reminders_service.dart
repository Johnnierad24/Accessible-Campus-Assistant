import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'notification_service.dart';

final _uuid = Uuid();

class ReminderItem {
  final String id;
  final String title;
  final String time;
  final bool done;
  final DateTime? scheduledAt;

  ReminderItem({
    String? id,
    required this.title,
    required this.time,
    this.done = false,
    this.scheduledAt,
  }) : id = id ?? _uuid.v4();

  ReminderItem copyWith({
    String? id,
    String? title,
    String? time,
    bool? done,
    DateTime? scheduledAt,
  }) {
    return ReminderItem(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      done: done ?? this.done,
      scheduledAt: scheduledAt ?? this.scheduledAt,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'time': time,
        'done': done,
        'scheduledAt': scheduledAt?.toIso8601String(),
      };

  factory ReminderItem.fromMap(Map<String, dynamic> map) {
    return ReminderItem(
      id: map['id'] as String? ?? _uuid.v4(),
      title: map['title'] as String? ?? '',
      time: map['time'] as String? ?? '',
      done: map['done'] as bool? ?? false,
      scheduledAt: map['scheduledAt'] != null
          ? DateTime.tryParse(map['scheduledAt'] as String)
          : null,
    );
  }
}

class RemindersService extends ChangeNotifier {
  RemindersService({NotificationService? notificationService})
      : _notificationService =
            notificationService ?? NotificationService.instance;

  static const _prefsKey = 'reminders';
  final NotificationService _notificationService;
  final List<ReminderItem> _items = [];
  bool _loaded = false;

  List<ReminderItem> get items => List.unmodifiable(_items);
  bool get isLoaded => _loaded;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw != null) {
      final decoded = jsonDecode(raw) as List<dynamic>;
      _items
        ..clear()
        ..addAll(decoded
            .map((e) => ReminderItem.fromMap(Map<String, dynamic>.from(e))));
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> addReminder(ReminderItem item,
      {bool triggerNotification = true}) async {
    _items.add(item);
    await _persist();
    if (triggerNotification) {
      await _notificationService.showReminder(item);
    }
    notifyListeners();
  }

  Future<void> markDone(ReminderItem item, {bool done = true}) async {
    final idx = _items.indexWhere((e) => e.id == item.id);
    if (idx == -1) return;
    _items[idx] = _items[idx].copyWith(done: done);
    await _persist();
    notifyListeners();
  }

  Future<void> snooze(ReminderItem item,
      {Duration duration = const Duration(minutes: 5)}) async {
    final idx = _items.indexWhere((e) => e.id == item.id);
    if (idx == -1) return;
    final scheduledAt = DateTime.now().add(duration);
    _items[idx] = _items[idx].copyWith(scheduledAt: scheduledAt, done: false);
    await _persist();
    await _notificationService.scheduleReminder(_items[idx], scheduledAt);
    notifyListeners();
  }

  Future<void> removeAt(int index) async {
    if (index < 0 || index >= _items.length) return;
    final removed = _items.removeAt(index);
    await _notificationService.cancel(removed.id.hashCode & 0x7fffffff);
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _prefsKey,
      jsonEncode(_items.map((e) => e.toMap()).toList()),
    );
  }
}
