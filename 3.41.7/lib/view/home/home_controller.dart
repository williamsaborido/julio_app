
import 'package:flutter/material.dart';
import 'package:julio_app/enums/lancamento_ciclo.dart';
import 'package:julio_app/models/lancamento.dart';
import 'package:julio_app/services/lancamento_repository.dart';

class HomeController extends ChangeNotifier {
  
  final LancamentoRepository _repository;

    //final list = List<Lancamento>.empty(growable: true);
  final list = [
    Lancamento(id: 0, ciclo: LancamentoCiclo.ciclo1, placa: 'ABC1234', data: DateTime(2024, 1, 1), valor: 100.0),
    Lancamento(id: 1, ciclo: LancamentoCiclo.ciclo1, placa: 'DEF5678', data: DateTime(2024, 2, 1), valor: 200.0),
    Lancamento(id: 2, ciclo: LancamentoCiclo.ciclo1, placa: 'GHI9012', data: DateTime(2024, 3, 1), valor: 300.0),
  ];

  HomeController({required LancamentoRepository repository }) : _repository = repository;
}