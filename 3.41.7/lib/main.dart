import 'package:flutter/material.dart';
import 'package:julio_app/core/system_theme.dart';
import 'package:julio_app/view/home/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       ChangeNotifierProvider<SystemTheme>(create: (_) => SystemTheme()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Demo',
            themeMode: context.watch<SystemTheme>().theme,
            theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),      
            darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
            ),
            initialRoute: '/home',
            routes: {
              '/home': (context) => const HomeView(),
            },
          );
        }
      ),
    );
  }
}