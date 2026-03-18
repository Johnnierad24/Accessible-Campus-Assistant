import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/services/notification_service.dart';
import 'src/services/reminders_service.dart';
import 'src/services/settings_service.dart';
import 'src/services/voice_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.instance.init();
  await VoiceService.instance.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsService()..load()),
        ChangeNotifierProvider(
          create: (_) => RemindersService(
              notificationService: NotificationService.instance)
            ..load(),
        ),
      ],
      child: const RootApp(),
    ),
  );
}
