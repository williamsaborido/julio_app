
import 'package:flutter/material.dart';
import 'package:julio_app/models/lancamento.dart';
import 'package:julio_app/services/lancamento_repository.dart';

class Controller extends ChangeNotifier {
  
  final LancamentoRepository _repository;
  final list = List<Lancamento>.empty(growable: true);

  Controller({required LancamentoRepository repository }) : _repository = repository;

  Future<void> getList() async {
    final lancamentos = await _repository.getList();
    list.clear();
    list.addAll(lancamentos);
    notifyListeners();
  }
}