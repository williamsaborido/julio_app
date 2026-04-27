import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final String placa;
  final String data;
  final String valor;

  const AppCard({
    super.key,
    required this.placa,
    required this.data,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Placa: $placa',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('C1', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Data: $data'),
                Text('Valor: $valor'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
