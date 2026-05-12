import 'package:flutter/material.dart';
import 'package:julio_app/enums/controller_state.dart';
import 'package:julio_app/models/lancamento.dart';
import 'package:julio_app/services/lancamento_repository.dart';

class CrudController extends ChangeNotifier {
  final LancamentoRepository _repository;
  ControllerState state = ControllerState.loading;
  final list = List<Lancamento>.empty(growable: true);

  CrudController({required LancamentoRepository repository})
    : _repository = repository;

  Future<void> get(int id) async {
    changeState(ControllerState.loading);
    final lancamentos = await _repository.getList();
    list.clear();
    list.addAll(lancamentos);
    changeState(ControllerState.success);
  }

  Future<void> create(Lancamento? data) async {
    if (data == null) return;
    changeState(ControllerState.saving);
    await _repository.create(data);
    changeState(ControllerState.success);
  }

  Future<void> update(Lancamento? data) async {
    if (data == null) return;
    changeState(ControllerState.saving);
    await _repository.update(data);
    changeState(ControllerState.success);
  }

  void changeState(ControllerState newState) {
    state = newState;
    notifyListeners();
  }
}
