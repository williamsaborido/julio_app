// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:julio_app/enums/lancamento_ciclo.dart';
import 'package:julio_app/models/table.dart';

final class Lancamento extends Table {
  final DateTime data;
  final LancamentoCiclo ciclo;
  final double valor;
  final String? placa;

  Lancamento({
    required super.id,
    required this.data,
    required this.ciclo,
    required this.valor,
    this.placa,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'data': data.millisecondsSinceEpoch,
      'ciclo': ciclo.value,
      'valor': (valor * 100).round(), // Armazena em centavos (int)
      'placa': placa,
    };
  }

  factory Lancamento.fromMap(Map<String, dynamic> map) {
    return Lancamento(
      id: map['id'] as int,
      data: DateTime.fromMillisecondsSinceEpoch(map['data'] as int),
      ciclo: LancamentoCiclo.fromValue(map['ciclo'] as int),
      valor: (map['valor'] as int) / 100.0, // Converte de centavos para double
      placa: map['placa'] != null ? map['placa'] as String : null,
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
  }) {
    return Lancamento(
      id: id ?? this.id,
      data: data ?? this.data,
      ciclo: ciclo ?? this.ciclo,
      valor: valor ?? this.valor,
      placa: placa ?? this.placa,
    );
  }
}
