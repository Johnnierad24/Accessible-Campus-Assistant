import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'src/app.dart';
import 'src/services/settings_service.dart';


void main() async {
WidgetsFlutterBinding.ensureInitialized();
runApp(
ChangeNotifierProvider(
create: (_) => SettingsService(),
child: const RootApp(),
),
);
}
