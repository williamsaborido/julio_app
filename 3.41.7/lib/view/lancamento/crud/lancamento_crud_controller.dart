import 'package:flutter/material.dart';
import 'package:julio_app/core/extensions.dart';
import 'package:julio_app/enums/controller_state.dart';
import 'package:julio_app/enums/lancamento_ciclo.dart';
import 'package:julio_app/models/lancamento.dart';
import 'package:julio_app/services/configuration.dart';
import 'package:julio_app/services/lancamento_repository.dart';

class LancamentoCrudController extends ChangeNotifier {
  final LancamentoRepository _repository;
  final Configuration _config;
  late final TextEditingController valorHoraExtraController = TextEditingController();
  ControllerState state = ControllerState.loading;

  DateTime selectedDate = DateTime.now();
  String placa = '';
  double valor = 0.0;
  double? _valorHoraExtra;
  TimeOfDay? _horaInicial;
  TimeOfDay? _horaFinal;
  int id = 0;
  bool hasHoraExtra = false;

  LancamentoCrudController({
    required LancamentoRepository repository,
    required Configuration config,
  }) : _repository = repository,
       _config = config;

  TimeOfDay? get horaInicial => _horaInicial;
  set horaInicial(TimeOfDay? value) {
    _horaInicial = value;
    _calculateOvertime();
    notifyListeners();
  }

  TimeOfDay? get horaFinal => _horaFinal;
  set horaFinal(TimeOfDay? value) {
    _horaFinal = value;
    _calculateOvertime();
    notifyListeners();
  }

  double? get valorHoraExtra => _valorHoraExtra;
  set valorHoraExtra(double? value) {
    _valorHoraExtra = value;
    notifyListeners();
  }

  void _calculateOvertime() {
    if (_horaInicial == null || _horaFinal == null) return;

    final startMinutes = _horaInicial!.hour * 60 + _horaInicial!.minute;
    final endMinutes = _horaFinal!.hour * 60 + _horaFinal!.minute;
    final diffMinutes = endMinutes - startMinutes;

    if (diffMinutes > 0) {
      _valorHoraExtra = (diffMinutes / 60.0) * _config.valorHoraExtra;
      valorHoraExtraController.text = _valorHoraExtra?.toBrCurrency() ?? '';
    }
  }

  Future<void> get(int lancamentoId) async {
    changeState(ControllerState.loading);

    final lancamento = await _repository.get(lancamentoId);

    if (lancamento == null) {
      changeState(ControllerState.error);
      return;
    }

    id = lancamento.id;
    selectedDate = lancamento.data;
    placa = lancamento.placa ?? '';
    valor = lancamento.valor;
    _valorHoraExtra = lancamento.valorHoraExtra;
    _horaInicial = lancamento.horaInicial;
    _horaFinal = lancamento.horaFinal;
    hasHoraExtra = lancamento.hasHoraExtra;
    valorHoraExtraController.text = _valorHoraExtra?.toBrCurrency() ?? '';

    changeState(ControllerState.success);
  }

  Future<void> create() async {
    changeState(ControllerState.saving);

    await _repository.create(Lancamento(
        id: id,
        data: selectedDate,
        placa: placa,
        valor: valor,
        valorHoraExtra: hasHoraExtra ? _valorHoraExtra : null,
        horaInicial: hasHoraExtra ? _horaInicial : null,
        horaFinal: hasHoraExtra ? _horaFinal : null,
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
        valorHoraExtra: hasHoraExtra ? _valorHoraExtra : null,
        horaInicial: hasHoraExtra ? _horaInicial : null,
        horaFinal: hasHoraExtra ? _horaFinal : null,
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
