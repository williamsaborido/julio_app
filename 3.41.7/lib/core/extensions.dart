import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:julio_app/enums/app_input_casing.dart';

extension AppStringExtension on String {
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
      final sanitized =
          replaceAll('R\$', '').replaceAll('.', '').replaceAll(',', '.').trim();
      return double.tryParse(sanitized);
    } catch (_) {
      return null;
    }
  }

  /// Converte uma String no padrão de horário (HH:mm) para TimeOfDay.
  TimeOfDay? toTime() {
    try {
      final parts = trim().split(':');
      if (parts.length != 2) return null;
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    } catch (_) {
      return null;
    }
  }

  /// Converte para Title Case (primeira letra de cada palavra em maiúsculo).
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ');
  }

  /// Aplica a transformação de casing baseada no enum [AppInputCasing].
  String applyCasing(AppInputCasing casing) {
    return switch (casing) {
      AppInputCasing.uppercase => toUpperCase(),
      AppInputCasing.lowercase => toLowerCase(),
      AppInputCasing.capitalize => toTitleCase(),
      _ => this,
    };
  }
}

extension DateTimeExtension on DateTime {
  /// Converte o DateTime para sua representação em String no padrão brasileiro (dd/MM/yyyy).
  String toBrString() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}

extension TimeOfDayExtension on TimeOfDay {
  /// Converte o TimeOfDay para sua representação em String (HH:mm).
  String toBrString() {
    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$hourStr:$minuteStr';
  }
}

extension DoubleExtension on double {
  /// Converte um double para sua representação em String no padrão de moeda brasileiro (R$).
  String toBrCurrency() {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(this);
  }
}