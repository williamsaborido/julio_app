import 'package:flutter/material.dart';
import 'package:julio_app/services/configuration.dart';
import 'package:julio_app/services/database.dart';
import 'package:julio_app/view/relatorio/impressao_view.dart';
import 'package:julio_app/view/shell/shell_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = Configuration();
  await config.init();

  runApp(MyApp(config: config));
}

class MyApp extends StatelessWidget {
  final Configuration config;
  const MyApp({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       Provider<Database>(create: (_) => Database()),
       ChangeNotifierProvider<Configuration>.value(value: config),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Demo',
            themeMode: context.watch<Configuration>().theme,
            theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),      
            darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
            ),
            initialRoute: '/',            
            routes: {
              '/': (_) => const ShellView(),
            },
          );
        }
      ),
    );
  }
}