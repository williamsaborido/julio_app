import 'package:flutter/material.dart';
import 'package:julio_app/core/extensions.dart';
import 'package:julio_app/enums/controller_state.dart';
import 'package:julio_app/enums/lancamento_ciclo.dart';
import 'package:julio_app/models/lancamento.dart';
import 'package:julio_app/services/lancamento_repository.dart';

class LancamentoCrudController extends ChangeNotifier {
  final LancamentoRepository _repository;
  ControllerState state = ControllerState.success;
  late final Lancamento? lancamento;

  DateTime selectedDate = DateTime.now();
  String placa = '';
  double valor = 0.0;
  double? valorHoraExtra;
  TimeOfDay? horaInicial;
  TimeOfDay? horaFinal;
  int id = 0;
  bool hasHoraExtra = false;

  LancamentoCrudController({required LancamentoRepository repository})
    : _repository = repository;

  Future<void> get(int id) async {
    changeState(ControllerState.loading);
    lancamento = await _repository.get(id);

    if (lancamento == null) {
      changeState(ControllerState.error);
      return;
    }

    this.id = lancamento!.id;
    selectedDate = lancamento!.data;
    placa = lancamento!.placa ?? '';
    valor = lancamento!.valor;
    valorHoraExtra = lancamento!.valorHoraExtra;
    horaInicial = lancamento!.horaInicial;
    horaFinal = lancamento!.horaFinal;
    hasHoraExtra = lancamento!.hasHoraExtra;

    changeState(ControllerState.success);
  }

  Future<void> create() async {
    changeState(ControllerState.saving);

    await _repository.create(Lancamento(
        id: id,
        data: selectedDate,
        placa: placa,
        valor: valor,
        valorHoraExtra: hasHoraExtra ? valorHoraExtra : null,
        horaInicial: hasHoraExtra ? horaInicial : null,
        horaFinal: hasHoraExtra ? horaFinal : null,
        ciclo: LancamentoCiclo.fromDate(selectedDate),
        ));

    changeState(ControllerState.success);
  }

  Future<void> update() async {
    changeState(ControllerState.saving);

    await _repository.update(Lancamento(
        id: id,
        data: selectedDate,
        placa: placa,
        valor: valor,
        valorHoraExtra: hasHoraExtra ? valorHoraExtra : null,
        horaInicial: hasHoraExtra ? horaInicial : null,
        horaFinal: hasHoraExtra ? horaFinal : null,
        ciclo: LancamentoCiclo.fromDate(selectedDate),
        ));

    changeState(ControllerState.success);
  }

  void validate() {}

  String? validateData(String? value) {
    if (value == null || value.isEmpty) {
      return 'Data é obrigatória';
    }
    return null;
  }

  String? validatePlaca(String? value) {
    if (value == null || value.isEmpty) {
      return 'Placa é obrigatória';
    }
    return null;
  }

  String? validateValor(String? value) {
    final amount = value?.toCurrency();
    if (amount == null || amount == 0.0) {
      return 'Valor inválido';
    }
    return null;
  }

  String? validateHora(String? value) {
    if (value == null || value.isEmpty) {
      return 'Hora é obrigatória';
    }
    return null;
  }

  void changeState(ControllerState newState) {
    state = newState;
    notifyListeners();
  }
}
