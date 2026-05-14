import 'package:flutter/material.dart';
import 'package:julio_app/components/app_currency_input/app_currency_input.dart';
import 'package:julio_app/components/app_date_input/app_date_input.dart';
import 'package:julio_app/components/app_text_input/app_text_input.dart';
import 'package:julio_app/core/base_state.dart';
import 'package:julio_app/enums/app_input_casing.dart';
import 'package:julio_app/enums/controller_state.dart';
import 'package:julio_app/view/lancamento/components/hora_extra_form/lancamento_hora_extra_form.dart';
import 'package:julio_app/view/lancamento/crud/lancamento_crud_controller.dart';
import 'package:provider/provider.dart';

class LancamentoCrudView extends StatefulWidget {
  
  const LancamentoCrudView({super.key});

  @override
  State<LancamentoCrudView> createState() => _LancamentoCrudViewState();
}

class _LancamentoCrudViewState extends BaseState<LancamentoCrudView> {
  final formKey = GlobalKey<FormState>();
  late final LancamentoCrudController controller;

  @override
  void initState() {
    controller = LancamentoCrudController(repository: context.read());
    super.initState();
  }

  @override
  void onInit() async {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      await controller.get(ModalRoute.of(context)!.settings.arguments as int);
    }
  }

  void onSave() {
    if (formKey.currentState?.validate() ?? false) {

      if (controller.id == 0) {
        controller.create();
      } else {
        controller.update();
      }

      if (context.mounted) Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.id == 0 ? 'Adicionar Lançamento' : 'Editar Lançamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
            if (controller.state == ControllerState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.state == ControllerState.error) {
              return const Center(child: Text('Erro ao carregar dados'));
            }

            return Form(
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
                      initialValue: controller.selectedDate,
                      onChanged: (value) => controller.selectedDate = value ?? DateTime.now(),                      
                      validator: controller.validateData,
                    ),
                    AppTextInput(
                      label: 'Placa',
                      icon: Icons.directions_car,
                      maxLength: 20,
                      initialValue: controller.placa,
                      casing: AppInputCasing.uppercase,
                      onChanged: (value) => controller.placa = value,
                      validator: controller.validatePlaca,
                    ),
                    AppCurrencyInput(
                      label: 'Valor',
                      icon: Icons.payments_outlined,
                      initialValue: controller.valor,
                      onChanged: (value) => controller.valor = value,
                      validator: controller.validateValor,
                    ),
                    LancamentoHoraExtraForm(
                      horaInicial: controller.horaInicial,
                      horaFinal: controller.horaFinal,
                      valorHoraExtra: controller.valorHoraExtra,
                      onHasHoraExtraChanged: (value) => controller.hasHoraExtra = value ?? false,
                      onHoraInicialChanged: (value) => controller.horaInicial = value,
                      onHoraFinalChanged: (value) => controller.horaFinal = value,
                      onValorHoraExtraChanged: (value) => controller.valorHoraExtra = value,                      
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
            );
          },
        ),
      ),
    );
  }
}
