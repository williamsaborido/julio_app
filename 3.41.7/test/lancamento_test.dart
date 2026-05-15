import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:julio_app/enums/lancamento_ciclo.dart';
import 'package:julio_app/models/lancamento.dart';

void main() {
  group('Lancamento Model Tests', () {
    test('minutosExtra calculation', () {
      final lancamento = Lancamento(
        id: 1,
        data: DateTime.now(),
        ciclo: LancamentoCiclo.ciclo1,
        valor: 100.0,
        horaInicial: const TimeOfDay(hour: 08, minute: 00),
        horaFinal: const TimeOfDay(hour: 09, minute: 30),
      );

      expect(lancamento.minutosExtra, 90);
    });

    test('minutosExtra with null values returns 0', () {
      final lancamento = Lancamento(
        id: 1,
        data: DateTime.now(),
        ciclo: LancamentoCiclo.ciclo1,
        valor: 100.0,
      );

      expect(lancamento.minutosExtra, 0);
    });

    test('minutosExtra where final < inicial returns 0 (per requirement)', () {
      final lancamento = Lancamento(
        id: 1,
        data: DateTime.now(),
        ciclo: LancamentoCiclo.ciclo1,
        valor: 100.0,
        horaInicial: const TimeOfDay(hour: 10, minute: 00),
        horaFinal: const TimeOfDay(hour: 09, minute: 00),
      );

      expect(lancamento.minutosExtra, 0);
    });

    test('toMap and fromMap with extra fields', () {
      final original = Lancamento(
        id: 1,
        data: DateTime(2023, 1, 1),
        ciclo: LancamentoCiclo.ciclo1,
        valor: 100.0,
        valorHoraExtra: 50.0,
        horaInicial: const TimeOfDay(hour: 8, minute: 30),
        horaFinal: const TimeOfDay(hour: 10, minute: 00),
      );

      final map = original.toMap();
      expect(map['valorHoraExtra'], 5000);
      expect(map['horaInicial'], 8 * 60 + 30);
      expect(map['horaFinal'], 10 * 60);

      final recovered = Lancamento.fromMap(map);
      expect(recovered.valorHoraExtra, 50.0);
      expect(recovered.horaInicial, const TimeOfDay(hour: 8, minute: 30));
      expect(recovered.horaFinal, const TimeOfDay(hour: 10, minute: 00));
      expect(recovered.minutosExtra, 90);
    });
  });
}
