import 'package:flutter/material.dart';
import 'package:julio_app/components/app_currency_input/app_currency_input.dart';
import 'package:julio_app/core/base_state.dart';
import 'package:julio_app/services/configuration.dart';
import 'package:provider/provider.dart';

class ConfigView extends StatefulWidget {
  const ConfigView({super.key});

  @override
  State<ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends BaseState<ConfigView> {
  late final Configuration _configuration;

  double valorHoraExtra = 0.0;

  @override
  void initState() {
    super.initState();
    _configuration = context.read<Configuration>();
    valorHoraExtra = _configuration.valorHoraExtra;
  }

  void _onClose() {
    _configuration.setValorHoraExtra(valorHoraExtra);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0,
        children: [
          Text(
            'Configurações',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Divider(),
          Text(
            'Tema',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ListenableBuilder(
            listenable: _configuration,
            builder: (context, _) {
              return Column(
                children: [
                  RadioListTile<ThemeMode>(
                    title: const Text('Claro'),
                    value: ThemeMode.light,
                    groupValue: _configuration.theme,
                    onChanged: (value) => _configuration.setTheme(value!),
                  ),
                  RadioListTile<ThemeMode>(
                    title: const Text('Escuro'),
                    value: ThemeMode.dark,
                    groupValue: _configuration.theme,
                    onChanged: (value) => _configuration.setTheme(value!),
                  ),
                  RadioListTile<ThemeMode>(
                    title: const Text('Sistema'),
                    value: ThemeMode.system,
                    groupValue: _configuration.theme,
                    onChanged: (value) => _configuration.setTheme(value!),
                  ),
                ],
              );
            },
          ),
          const Divider(),
          Text(
            'Valor Hora Extra',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AppCurrencyInput(
            label: 'Valor',
            icon: Icons.monetization_on_outlined,
            initialValue: valorHoraExtra,
            onChanged: (value) => valorHoraExtra = value,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _onClose,
                  child: const Text('FECHAR'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
