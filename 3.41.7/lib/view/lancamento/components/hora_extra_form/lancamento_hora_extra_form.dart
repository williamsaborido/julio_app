import 'package:flutter/material.dart';
import 'package:julio_app/components/app_currency_input/app_currency_input.dart';
import 'package:julio_app/components/app_time_input/app_time_input.dart';
import 'package:julio_app/core/extensions.dart';

class LancamentoHoraExtraForm extends StatefulWidget {
  final TimeOfDay? horaInicial;
  final TimeOfDay? horaFinal;
  final double? valorHoraExtra;
  final ValueChanged<TimeOfDay?>? onHoraInicialChanged;
  final ValueChanged<TimeOfDay?>? onHoraFinalChanged;
  final ValueChanged<double?>? onValorHoraExtraChanged;
  final ValueChanged<bool?>? onHasHoraExtraChanged;

  const LancamentoHoraExtraForm({
    this.horaInicial,
    this.horaFinal,
    this.valorHoraExtra,
    this.onHoraInicialChanged,
    this.onHoraFinalChanged,
    this.onValorHoraExtraChanged,
    this.onHasHoraExtraChanged,
    super.key,
  });

  @override
  State<LancamentoHoraExtraForm> createState() =>
      _LancamentoHoraExtraFormState();
}

class _LancamentoHoraExtraFormState extends State<LancamentoHoraExtraForm> {
  final ExpansibleController controller = ExpansibleController();
  late final ValueNotifier<bool> hasHoraExtra;

  @override
  void initState() {
    super.initState();
    hasHoraExtra = ValueNotifier(widget.horaInicial != null);
    controller.addListener(expansionListener);
  }

  @override
  void dispose() {
    controller.removeListener(expansionListener);
    hasHoraExtra.dispose();
    super.dispose();
  }

  void expansionListener() {
    hasHoraExtra.value = controller.isExpanded;
    widget.onHasHoraExtraChanged?.call(hasHoraExtra.value);
  }

  String? validateHora(String? value) {
    if (hasHoraExtra.value && (value == null || value.isEmpty)) {
      return 'Hora é obrigatória';
    }
    return null;
  }

  String? validateValor(String? value) {
    final amount = value?.toCurrency();
    if (hasHoraExtra.value && (amount == null || amount == 0.0)) {
      return 'Valor inválido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: controller,
      collapsedBackgroundColor: Theme.of(
        context,
      ).colorScheme.secondaryContainer,
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      trailing: ValueListenableBuilder(
        valueListenable: hasHoraExtra,
        builder: (context, value, child) {
          return Checkbox(value: hasHoraExtra.value, onChanged: (value) {});
        },
      ),
      title: Text('Hora Extra'),
      initiallyExpanded: hasHoraExtra.value,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16.0,
            children: [
              AppTimeInput(
                label: 'Hora Inicial',
                icon: Icons.access_time,
                initialValue: widget.horaInicial,
                onChanged: widget.onHoraInicialChanged,
                validator: validateHora,
              ),
              AppTimeInput(
                label: 'Hora Final',
                icon: Icons.access_time_filled,
                initialValue: widget.horaFinal,
                onChanged: widget.onHoraFinalChanged,
                validator: validateHora,
              ),
              AppCurrencyInput(
                label: 'Valor da Hora Extra',
                icon: Icons.price_change_outlined,
                initialValue: widget.valorHoraExtra,
                onChanged: widget.onValorHoraExtraChanged,
                validator: validateValor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
