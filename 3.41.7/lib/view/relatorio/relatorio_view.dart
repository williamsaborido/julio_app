import 'package:flutter/material.dart';
import 'package:julio_app/view/relatorio/impressao_view.dart';

class RelatorioView extends StatelessWidget {
  const RelatorioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Tela de Relatório em construção'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ImpressaoView(),
                    fullscreenDialog: true, // Faz com que o ícone de voltar vire um 'X' em algumas plataformas
                  ),
                );
              },
              icon: const Icon(Icons.print),
              label: const Text('Ver Impressão (Tela Cheia)'),
            ),
          ],
        ),
      ),
    );
  }
}
