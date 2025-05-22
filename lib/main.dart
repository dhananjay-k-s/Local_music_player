import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunesync/screen/home_screen.dart';
import 'package:tunesync/service/settings_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: settings.currentTheme,
          home: const HomeScreen(),
        );
      },
    );
  }
}
