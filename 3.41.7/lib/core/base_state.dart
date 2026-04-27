import 'package:flutter/material.dart';
import 'package:julio_app/components/app_alert_dialog/app_alert_dialog.dart';
import 'package:julio_app/components/app_confirm_dialog/app_confirm_dialog.dart';

/// Classe base para uso do contexo para navegação, snackbar e tamanho de tela
abstract class BaseState<T extends StatefulWidget> extends State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onInit());
  }

  /// Método chamado após a inicialização do widget (postFrameCallback)
  void onInit() {}

  /// Obtém largura da tela
  double get screenWidth => MediaQuery.of(context).size.width;

  /// Obtém altura da tela
  double get screenHeight => MediaQuery.of(context).size.height;

  /// Navega para uma nova tela (adiciona widget da rota no topo da pilha de navegação)
  Future<void> navigateTo(String route, {Object? args}) {
    if (mounted) {
      return Navigator.of(context).pushNamed(route, arguments: args);
    }

    return Future.value();
  }

  /// Navega para uma nova tela (adiciona widget da rota no topo da pilha de navegação) e retorna um objeto result
  Future<Object?> navigateToAndReturn(String route, {Object? args}) {
    if (mounted) {
      return Navigator.of(context).pushNamed(route, arguments: args);
    }

    return Future.value();
  }

  /// "Navega de volta", removendo a rota, ou widget atual, da pilha de navegação, 
  /// mas não faz a navegação se este widget for o único na pilha
  Future<void> navigateBack({Object? args}) {
    if (mounted) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop(args);
      }
    }

    return Future.value();
  }

  /// Navega para uma nova rota removendo todas as outras telas da pilha de navegação
    Future<void> navigateToAndReset(String route, {Object? args}) {
    if (mounted) {
      return Navigator.of(context)
          .pushNamedAndRemoveUntil(route, (_) => false, arguments: args);
    }

    return Future.value();
  }

  /// Navega para uma nova tela e remove a rota atual da pilha de navegação
    Future<void> navigateToAndReplace(String route, {Object? args}) {
    if (mounted) {
      return Navigator.of(context).pushReplacementNamed(route, arguments: args);
    }

    return Future.value();
  }

  /// Remove todas as snackbars atualmente exibidas
  void clearSnackbars() {
    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
    }
  }

  /// Exibe uma snackbar com a mensagem fornecida pelo parâmetro [message]
  void showSnackbar(String message) {
    if (mounted) {
      clearSnackbars();

      final snackbar = SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          onPressed: clearSnackbars,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  /// Exibe um modal com o conteúdo fornecido pelo parâmetro [content],
  /// se [dismissible] for true, o modal pode ser fechado ao clicar fora dele
  void showModal(Widget content, {bool dismissible = true}) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          child: content,
        );
      },
    );
  }

  /// Exibe um diálogo de confirmação com a mensagem fornecida pelo parâmetro [message], 
  /// aceitando um título opcional em [title], retornando true se o usuário confirmar
  Future<bool> confirm(String message, { String? title }){
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AppConfirmDialog(message: message, title: title);
      },
    ).then((value) => value ?? false);
  }

  /// Exibe um diálogo de alerta com a mensagem fornecida pelo parâmetro [message],
  /// aceitando um título opcional em [title]
  Future<void> alert(String message, { String? title }){
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AppAlertDialog(message: message, title: title);
      },
    );
  }  
}
