import 'package:flutter/material.dart';
import 'package:julio_app/components/app_input/app_input.dart';
import 'package:julio_app/core/extensions.dart';
import 'package:julio_app/enums/app_input_casing.dart';
import 'package:julio_app/enums/app_input_type.dart';
import 'package:julio_app/enums/lancamento_ciclo.dart';
import 'package:julio_app/models/lancamento.dart';

class LancamentoCrud extends StatefulWidget {
  const LancamentoCrud({super.key});

  @override
  State<LancamentoCrud> createState() => _LancamentoCrudState();
}

class _LancamentoCrudState extends State<LancamentoCrud> {
  final formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  String placa = '';
  double valor = 0.0;
  int ciclo = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 16.0,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 16.0,
                children: [Icon(Icons.add), Text('Adicionar lançamento')],
              ),
              AppInput(
                label: 'Data',
                icon: Icons.calendar_month,
                type: AppInputType.date,
                onChanged: (value) {
                  selectedDate = value.toDate() ?? DateTime.now();
                },
                validator: (value){
                  if (value == null || !value.isDate()){
                    return 'Data inválida';
                  }
                  return null;
                },
              ),
              AppInput(
                label: 'Placa',
                icon: Icons.directions_car,
                type: AppInputType.text,
                casing: AppInputCasing.uppercase,
                onChanged: (value) {
                  placa = value;
                },
                validator: (value){
                  if (value == null || value.trim().isEmpty){
                    return 'Placa é obrigatória';
                  }
                  return null;
                },
              ),
              AppInput(
                label: 'Valor',
                icon: Icons.payments_outlined,
                type: AppInputType.currency,
                onChanged: (value) {
                  valor = value.toCurrency() ?? 0.0;
                },
                validator: (value){
                  if (value == null || value.toCurrency() == null || value.toCurrency() == 0.0){
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
                            Navigator.pop(context, Lancamento(
                              id: 0,
                              data: selectedDate,
                              placa: placa,
                              valor: valor,
                              ciclo: LancamentoCiclo.fromDate(selectedDate),
                            ));
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
    );
  }


}
