import 'package:flutter/material.dart';

class ImpressaoView extends StatelessWidget {
  const ImpressaoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impressão de Relatório'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.print, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'Simulação de visualização de impressão',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'Esta tela abriu sobre a barra de navegação porque foi disparada usando o Navigator raiz do aplicativo.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
