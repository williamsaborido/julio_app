import 'package:flutter/material.dart';
import 'package:julio_app/components/app_currency_input/app_currency_input.dart';
import 'package:julio_app/components/app_date_input/app_date_input.dart';
import 'package:julio_app/components/app_text_input/app_text_input.dart';
import 'package:julio_app/components/app_time_input/app_time_input.dart';
import 'package:julio_app/core/base_state.dart';
import 'package:julio_app/core/extensions.dart';
import 'package:julio_app/enums/app_input_casing.dart';
import 'package:julio_app/enums/lancamento_ciclo.dart';
import 'package:julio_app/models/lancamento.dart';
import 'package:julio_app/view/lancamento/crud/crud_controller.dart';
import 'package:provider/provider.dart';

class LancamentoCrud extends StatefulWidget {
  const LancamentoCrud({super.key});

  @override
  State<LancamentoCrud> createState() => _LancamentoCrudState();
}

class _LancamentoCrudState extends BaseState<LancamentoCrud> {
  final formKey = GlobalKey<FormState>();
  late final CrudController controller;

  DateTime selectedDate = DateTime.now();
  String placa = '';
  double valor = 0.0;
  double? valorHoraExtra;
  TimeOfDay? horaInicial;
  TimeOfDay? horaFinal;
  int id = 0;

  @override
  void initState() {
    controller = CrudController(repository: context.read());
    super.initState();
  }

  @override
  void onInit() {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final Lancamento data =
          ModalRoute.of(context)!.settings.arguments as Lancamento;

      setState(() {
        selectedDate = data.data;
        placa = data.placa ?? '';
        valor = data.valor;
        valorHoraExtra = data.valorHoraExtra;
        horaInicial = data.horaInicial;
        horaFinal = data.horaFinal;
        id = data.id;
      });
    }
  }

  void onSave() {
    if (formKey.currentState?.validate() ?? false) {
      final lancamento = Lancamento(
        id: id,
        data: selectedDate,
        placa: placa,
        valor: valor,
        valorHoraExtra: valorHoraExtra,
        horaInicial: horaInicial,
        horaFinal: horaFinal,
        ciclo: LancamentoCiclo.fromDate(selectedDate),
      );

      if (id == 0) {
        controller.create(lancamento);
      } else {
        controller.update(lancamento);
      }

      if (context.mounted) Navigator.pop(context, lancamento);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id == 0 ? 'Adicionar Lançamento' : 'Editar Lançamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 16.0,
              children: [
                AppDateInput(
                  label: 'Data',
                  icon: Icons.calendar_month,
                  initialValue: selectedDate,
                  onChanged: (value) {
                    if (value != null) selectedDate = value;
                  },
                  validator: (value) => value == null ? 'Data inválida' : null,
                ),
                AppTextInput(
                  label: 'Placa',
                  icon: Icons.directions_car,
                  maxLength: 20,
                  initialValue: placa,
                  casing: AppInputCasing.uppercase,
                  onChanged: (value) {
                    placa = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Placa é obrigatória';
                    }
                    return null;
                  },
                ),
                AppCurrencyInput(
                  label: 'Valor',
                  icon: Icons.payments_outlined,
                  initialValue: valor,
                  onChanged: (value) {
                    valor = value;
                  },
                  validator: (value) {
                    final amount = value?.toCurrency();
                    if (amount == null || amount == 0.0) {
                      return 'Valor inválido';
                    }
                    return null;
                  },
                ),
                ExpansionTile(
                  collapsedBackgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  title: Text('Hora Extra'),
                  initiallyExpanded: valorHoraExtra != null,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        spacing: 16.0,
                        children: [
                          AppTimeInput(
                            label: 'Hora Inicial',
                            icon: Icons.access_time,
                            initialValue: horaInicial,
                            onChanged: (value) {
                              horaInicial = value;
                            },
                          ),
                          AppTimeInput(
                            label: 'Hora Final',
                            icon: Icons.access_time_filled,
                            initialValue: horaFinal,
                            onChanged: (value) {
                              horaFinal = value;
                            },
                          ),
                          AppCurrencyInput(
                            label: 'Valor da Hora Extra',
                            icon: Icons.price_change_outlined,
                            initialValue: valorHoraExtra,
                            onChanged: (value) {
                              valorHoraExtra = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      spacing: 16.0,
                      children: [
                        Icon(Icons.info_outline),
                        Expanded(
                          child: Text(
                            'O ciclo (1 ou 2) será definido automaticamente com base na data do lançamento',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onSave,
                        child: Text('SALVAR'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
