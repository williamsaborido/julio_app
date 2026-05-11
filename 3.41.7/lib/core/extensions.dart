import 'package:intl/intl.dart';

extension DateStringExtension on String {
  /// Converte uma String no padrão brasileiro (dd/MM/yyyy) para DateTime,
  /// desprezando a parte de tempo.
  DateTime? toDate() {
    try {
      return DateFormat('dd/MM/yyyy').parseStrict(trim());
    } catch (_) {
      return null;
    }
  }

  /// Verifica se a String é uma data válida no padrão brasileiro (dd/MM/yyyy).
  bool isDate() => toDate() != null;

  /// Converte uma String no padrão de moeda brasileiro (R$) para double.
  double? toCurrency() {
    try {
      final sanitized = replaceAll('R\$', '').replaceAll('.', '').replaceAll(',', '.').trim();
      return double.tryParse(sanitized);
    } catch (_) {
      return null;
    }
  }
}

extension DateTimeExtension on DateTime {
  /// Converte o DateTime para sua representação em String no padrão brasileiro (dd/MM/yyyy).
  String toBrString() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}

extension DoubleExtension on double {
  /// Converte um double para sua representação em String no padrão de moeda brasileiro (R$).
  String toBrCurrency() {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(this);
  }
}