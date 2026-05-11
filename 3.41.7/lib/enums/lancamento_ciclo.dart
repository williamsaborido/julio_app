import 'package:flutter/material.dart';

enum LancamentoCiclo {
  ciclo1(1, 'C1', Colors.green),
  ciclo2(2, 'C2', Colors.blue);

  final int value;
  final String label;  
  final Color color;

  const LancamentoCiclo(this.value, this.label, this.color);

  /// Método estático para buscar o enum a partir de um valor inteiro
  static LancamentoCiclo fromValue(int val) {
    return LancamentoCiclo.values.firstWhere(
      (e) => e.value == val,
      orElse: () => LancamentoCiclo.ciclo1,
    );
  }

  static LancamentoCiclo fromDate(DateTime date) {
    final day = date.day;
    if (day >= 16) {
      return LancamentoCiclo.ciclo2;
    } else {
      return LancamentoCiclo.ciclo1;
    }
  }
}