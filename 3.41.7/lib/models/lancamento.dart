// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart' hide Table;
import 'package:julio_app/enums/lancamento_ciclo.dart';
import 'package:julio_app/models/table.dart';

final class Lancamento extends Table {
  final DateTime data;
  final LancamentoCiclo ciclo;
  final double valor;
  final String? placa;
  final double? valorHoraExtra;
  final TimeOfDay? horaInicial;
  final TimeOfDay? horaFinal;

  bool get hasHoraExtra => horaInicial != null;
  double get total => valor + (valorHoraExtra ?? 0.0);

  Lancamento({
    required super.id,
    required this.data,
    required this.ciclo,
    required this.valor,
    this.placa,
    this.valorHoraExtra,
    this.horaInicial,
    this.horaFinal,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'data': data.millisecondsSinceEpoch,
      'ciclo': ciclo.value,
      'valor': (valor * 100).round(), // Armazena em centavos (int)
      'placa': placa,
      'valorHoraExtra': valorHoraExtra != null
          ? (valorHoraExtra! * 100).round()
          : null,
      'horaInicial': horaInicial != null
          ? (horaInicial!.hour * 60 + horaInicial!.minute)
          : null,
      'horaFinal': horaFinal != null
          ? (horaFinal!.hour * 60 + horaFinal!.minute)
          : null,
    };
  }

  factory Lancamento.fromMap(Map<String, dynamic> map) {
    return Lancamento(
      id: map['id'] as int,
      data: DateTime.fromMillisecondsSinceEpoch(map['data'] as int),
      ciclo: LancamentoCiclo.fromValue(map['ciclo'] as int),
      valor: (map['valor'] as int) / 100.0, // Converte de centavos para double
      placa: map['placa'] != null ? map['placa'] as String : null,
      valorHoraExtra: map['valorHoraExtra'] != null
          ? (map['valorHoraExtra'] as int) / 100.0
          : null,
      horaInicial: map['horaInicial'] != null
          ? TimeOfDay(
              hour: (map['horaInicial'] as int) ~/ 60,
              minute: (map['horaInicial'] as int) % 60,
            )
          : null,
      horaFinal: map['horaFinal'] != null
          ? TimeOfDay(
              hour: (map['horaFinal'] as int) ~/ 60,
              minute: (map['horaFinal'] as int) % 60,
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lancamento.fromJson(String source) =>
      Lancamento.fromMap(json.decode(source) as Map<String, dynamic>);

  Lancamento copyWith({
    int? id,
    DateTime? data,
    LancamentoCiclo? ciclo,
    double? valor,
    String? placa,
    double? valorHoraExtra,
    TimeOfDay? horaInicial,
    TimeOfDay? horaFinal,
  }) {
    return Lancamento(
      id: id ?? this.id,
      data: data ?? this.data,
      ciclo: ciclo ?? this.ciclo,
      valor: valor ?? this.valor,
      placa: placa ?? this.placa,
      valorHoraExtra: valorHoraExtra ?? this.valorHoraExtra,
      horaInicial: horaInicial ?? this.horaInicial,
      horaFinal: horaFinal ?? this.horaFinal,
    );
  }

  /// Calcula a diferença em minutos entre hora inicial e final (mesmo dia).
  int get minutosExtra {
    if (horaInicial == null || horaFinal == null) return 0;
    final inicio = horaInicial!.hour * 60 + horaInicial!.minute;
    final fim = horaFinal!.hour * 60 + horaFinal!.minute;
    return (fim > inicio) ? fim - inicio : 0;
  }
}
