import 'package:flutter/material.dart';
import 'package:julio_app/components/app_input/app_input.dart';
import 'package:julio_app/core/base_state.dart';
import 'package:julio_app/core/extensions.dart';
import 'package:julio_app/enums/app_input_casing.dart';
import 'package:julio_app/enums/app_input_type.dart';
import 'package:julio_app/enums/lancamento_ciclo.dart';
import 'package:julio_app/models/lancamento.dart';
import 'package:julio_app/services/lancamento_repository.dart';
import 'package:provider/provider.dart';

class LancamentoCrud extends StatefulWidget {
  const LancamentoCrud({super.key});

  @override
  State<LancamentoCrud> createState() => _LancamentoCrudState();
}

class _LancamentoCrudState extends BaseState<LancamentoCrud> {
  final formKey = GlobalKey<FormState>();
  late final LancamentoRepository repository;

  DateTime selectedDate = DateTime.now();
  String placa = '';
  double valor = 0.0;
  int ciclo = 1;
  int id = 0;

  @override
  void initState() {
    repository = LancamentoRepository(context.read());
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
        ciclo = data.ciclo.value;
        id = data.id;
      });
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
                AppInput(
                  label: 'Data',
                  icon: Icons.calendar_month,
                  type: AppInputType.date,
                  initialValue: selectedDate.toBrString(),
                  onChanged: (value) {
                    selectedDate = value.toDate() ?? DateTime.now();
                  },
                  validator: (value) {
                    if (value == null || !value.isDate()) {
                      return 'Data inválida';
                    }
                    return null;
                  },
                ),
                AppInput(
                  label: 'Placa',
                  icon: Icons.directions_car,
                  maxLength: 20,
                  type: AppInputType.text,
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
                AppInput(
                  label: 'Valor',
                  icon: Icons.payments_outlined,
                  type: AppInputType.currency,
                  initialValue: valor != 0.0 ? valor.toBrCurrency() : null,
                  onChanged: (value) {
                    valor = value.toCurrency() ?? 0.0;
                  },
                  validator: (value) {
                    if (value == null ||
                        value.toCurrency() == null ||
                        value.toCurrency() == 0.0) {
                      return 'Valor inválido';
                    }
                    return null;
                  },
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
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            if (context.mounted) {
                              Navigator.pop(
                                context,
                                Lancamento(
                                  id: id,
                                  data: selectedDate,
                                  placa: placa,
                                  valor: valor,
                                  ciclo: LancamentoCiclo.fromDate(selectedDate),
                                ),
                              );
                            }
                          }
                        },
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
