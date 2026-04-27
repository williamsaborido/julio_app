// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:julio_app/enums/lancamento_ciclo.dart';

class Lancamento {
  final String id;
  final DateTime data;
  final LancamentoCiclo ciclo;
  final double valor;
  final String? placa;

  Lancamento({
    required this.id,
    required this.data,
    required this.ciclo,
    required this.valor,
    this.placa,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'data': data.millisecondsSinceEpoch,
      'ciclo': ciclo.value,
      'valor': valor,
      'placa': placa,
    };
  }

  factory Lancamento.fromMap(Map<String, dynamic> map) {
    return Lancamento(
      id: map['id'] as String,
      data: DateTime.fromMillisecondsSinceEpoch(map['data'] as int),
      ciclo: LancamentoCiclo.fromValue(map['ciclo'] as int),
      valor: map['valor'] as double,
      placa: map['placa'] != null ? map['placa'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lancamento.fromJson(String source) => Lancamento.fromMap(json.decode(source) as Map<String, dynamic>);
}
