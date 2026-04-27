import 'package:flutter/material.dart';

/// Diálogo de alerta com botão de OK, usado para mostrar um aviso importante ao usuário
/// Usado em conjunto com a função 'alert' da classe [BaseState]
class AppAlertDialog extends StatelessWidget {
/// Mensagem a ser exibida ao usuário
final String message;

/// Título do diálogo (por padrão, é a string 'Cuidar +')
final String? title;

  /// Cria um diálogo de alerta com botão de OK, usado para mostrar um aviso importante ao usuário
  /// Usado em conjunto com a função 'alert' da classe [BaseState]
  const AppAlertDialog({ required this.message, this.title, super.key });

   @override
   Widget build(BuildContext context) {
       return AlertDialog(
          title: Text(title == null ? 'App' : title!),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
  }
}