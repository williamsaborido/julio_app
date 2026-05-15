import 'package:flutter/material.dart';
import 'package:julio_app/services/lancamento_repository.dart';
import 'package:julio_app/view/lancamento/crud/lancamento_crud_view.dart';
import 'package:julio_app/view/lancamento/home/lancamento_home_view.dart';
import 'package:provider/provider.dart';

class LancamentoBind extends StatelessWidget {
  const LancamentoBind({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return Provider(
      create: (context) => LancamentoRepository(context.read()),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          final NavigatorState? navigator = navigatorKey.currentState;
          if (navigator != null && navigator.canPop()) {
            navigator.pop();
          } else {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          }
        },
        child: Navigator(
          key: navigatorKey,
          initialRoute: '/home',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/home':
                return MaterialPageRoute(
                  builder: (_) => const LancamentoHomeView(),
                  settings: settings,
                );
              case '/crud':
                return MaterialPageRoute(
                  builder: (_) => const LancamentoCrudView(),
                  settings: settings,
                );
              default:
                return null;
            }
          },
        ),
      ),
    );
  }
}
