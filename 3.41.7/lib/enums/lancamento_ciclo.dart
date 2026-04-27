import 'package:flutter/material.dart';

enum LancamentoCiclo {
  ciclo1(1, 'Ciclo 1', Colors.green),
  ciclo2(2, 'Ciclo 2', Colors.blue);

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
}