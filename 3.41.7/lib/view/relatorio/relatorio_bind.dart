import 'package:flutter/material.dart';
import 'package:julio_app/services/pdf_service.dart';
import 'package:julio_app/services/sharing.dart';
import 'package:julio_app/view/relatorio/impressao_view.dart';
import 'package:julio_app/view/relatorio/relatorio_view.dart';
import 'package:provider/provider.dart';

class RelatorioBind extends StatelessWidget {
  const RelatorioBind({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => PdfService()),
        Provider(
          create: (_) => SharingService(),
        ), // Adicione aqui os providers necessários para o Relatório
      ],
      child: Navigator(
        initialRoute: '/relatorio',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/relatorio':
              return MaterialPageRoute(
                builder: (_) => const RelatorioView(),
                settings: settings,
              );
              case '/lancamento/relatorio/impressao':
              return MaterialPageRoute(
                builder: (_) => const ImpressaoView(),
                settings: settings,
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
