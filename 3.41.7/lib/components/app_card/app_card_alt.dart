import 'package:flutter/material.dart';

class AppCardAlt extends StatelessWidget {
  final String placa;
  final String data;
  final String valor;
  final VoidCallback onDelete;
  final String cicloLabel;
  final Color cicloColor;

  const AppCardAlt({
    super.key,
    required this.placa,
    required this.data,
    required this.valor,
    required this.onDelete,
    this.cicloLabel = 'C1',
    this.cicloColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Identificador do Ciclo
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: cicloColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  cicloLabel.toUpperCase(),
                  style: TextStyle(
                    color: cicloColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Informações do Lançamento
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    placa.isEmpty ? 'Sem Placa' : placa,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        data,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          '•',
                          style: TextStyle(
                            color: Theme.of(context).dividerColor.withOpacity(0.3),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        valor,
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Botão de Exclusão
            IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete_outline_rounded,
                color: Colors.red.withOpacity(0.7),
                size: 22,
              ),
              tooltip: 'Excluir Lançamento',
            ),
          ],
        ),
      ),
    );
  }
}
