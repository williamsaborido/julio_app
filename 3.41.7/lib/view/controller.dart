import 'package:flutter/material.dart';
import 'package:julio_app/models/lancamento.dart';
import 'package:julio_app/services/lancamento_repository.dart';

enum ControllerState { loading, saving, deleting, success, error }

class Controller extends ChangeNotifier {
  final LancamentoRepository _repository;
  ControllerState state = ControllerState.loading;
  final list = List<Lancamento>.empty(growable: true);

  Controller({required LancamentoRepository repository})
    : _repository = repository;

  Future<void> getList() async {
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
    changeState(ControllerState.loading);
    getList();
    changeState(ControllerState.success);
  }

  Future<void> update(Lancamento? data) async {
    if (data == null) return;
    changeState(ControllerState.saving);
    await _repository.update(data);
    changeState(ControllerState.loading);
    getList();
    changeState(ControllerState.success);
  }

  Future<void> delete(int id) async {
    changeState(ControllerState.deleting);
    await _repository.delete(id);
    changeState(ControllerState.loading);
    getList();
    changeState(ControllerState.success);
  }

  void changeState(ControllerState newState) {
    state = newState;
    notifyListeners();
  }
}
