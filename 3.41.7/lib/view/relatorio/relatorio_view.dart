import 'package:flutter/material.dart';
import 'package:julio_app/core/base_state.dart';
import 'package:julio_app/view/relatorio/impressao_view.dart';

class RelatorioView extends StatefulWidget {
  const RelatorioView({super.key});

  @override
  State<RelatorioView> createState() => _RelatorioViewState();
}

class _RelatorioViewState extends BaseState<RelatorioView> {
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
                navigateTo('/lancamento/relatorio/impressao');
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
