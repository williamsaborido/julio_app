import 'package:flutter/material.dart';
import 'package:julio_app/enums/controller_state.dart';
import 'package:julio_app/models/lancamento.dart';
import 'package:julio_app/services/lancamento_repository.dart';

class LancamentoHomeController extends ChangeNotifier {
  final LancamentoRepository _repository;
  ControllerState state = ControllerState.loading;
  final list = List<Lancamento>.empty(growable: true);

  LancamentoHomeController({required LancamentoRepository repository})
    : _repository = repository;

  Future<void> getList() async {
    changeState(ControllerState.loading);
    final lancamentos = await _repository.getList();
    list.clear();
    list.addAll(lancamentos);
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
