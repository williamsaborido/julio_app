import 'package:flutter/material.dart';

/// Diálogo de confirmação com botão 'Cancelar' e outro 'Confirmar', usado para solicitar uma comfirmação ao usuário
/// Usado em conjunto com a função 'confirm' da classe [BaseState]
class AppConfirmDialog extends StatelessWidget {
/// Mensagem, ou pergunta, a ser exibida ao usuário
final String message;

/// Título do diálogo (por padrão, é a string 'Cuidar +')
final String? title;

  /// Cria um diálogo de confirmação com botão 'Cancelar' e outro 'Confirmar', usado para solicitar uma comfirmação ao usuário
  /// Usado em conjunto com a função 'confirm' da classe [BaseState]
  const AppConfirmDialog({ required this.message, this.title, super.key });

   @override
   Widget build(BuildContext context) {
       return AlertDialog(
          title: Text(title == null ? 'App' : title!),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirmar'),
            ),
          ],
        );
  }
}