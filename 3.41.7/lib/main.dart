import 'package:flutter/material.dart';
import 'package:julio_app/core/system_theme.dart';
import 'package:julio_app/models/lancamento.dart';
import 'package:julio_app/services/database.dart';
import 'package:julio_app/view/crud/lancamento_crud.dart';
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
       Provider<Database>(create: (_) => Database()),
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
            onGenerateInitialRoutes: (initialRoute) => [
              MaterialPageRoute(builder: (context) => const HomeView()),
            ],
            onGenerateRoute: (settings) => switch (settings.name) {
              '/lancamento/crud' => MaterialPageRoute<Lancamento?>(builder: (context) => const LancamentoCrud(), settings: settings),
              _ => null,
            },
          );
        }
      ),
    );
  }
}