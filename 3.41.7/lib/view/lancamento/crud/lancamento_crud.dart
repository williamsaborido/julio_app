import 'package:flutter/material.dart';
import 'package:julio_app/components/app_input/app_input.dart';
import 'package:julio_app/enums/app_input_casing.dart';
import 'package:julio_app/enums/app_input_type.dart';

class LancamentoCrud extends StatefulWidget {
  const LancamentoCrud({super.key});

  @override
  State<LancamentoCrud> createState() => _LancamentoCrudState();
}

class _LancamentoCrudState extends State<LancamentoCrud> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
          ),
          AppInput(
            label: 'Placa',
            icon: Icons.directions_car,
            type: AppInputType.text,
            casing: AppInputCasing.uppercase,
          ),
          AppInput(
            label: 'Valor',
            icon: Icons.payments_outlined,
            type: AppInputType.currency,
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
                  onPressed: () => Navigator.pop(context),
                  child: Text('SALVAR'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
