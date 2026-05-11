import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:julio_app/components/app_card/app_card_alt.dart';
import 'package:julio_app/core/base_state.dart';
import 'package:julio_app/core/system_theme.dart';
import 'package:julio_app/services/lancamento_repository.dart';
import 'package:julio_app/view/controller.dart';
import 'package:julio_app/view/dialog/lancamento_crud.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> {
  late final Controller controller;
  late final SystemTheme theme;

  final _dateFormatter = DateFormat('dd/MM/yyyy');
  final _currencyFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  @override
  void initState() {
    super.initState();
    theme = context.read<SystemTheme>();
    controller = Controller(repository: LancamentoRepository(context.read()));
  }

  @override
  void onInit() {
    controller.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lançamentos'),
        actions: [
          ListenableBuilder(
            listenable: context.watch<SystemTheme>(),
            builder: (context, _) {
              return IconButton(
                onPressed: _toggleTheme,
                icon: Icon(switch (theme.theme) {
                  ThemeMode.light => Icons.light_mode,
                  ThemeMode.dark => Icons.dark_mode,
                  ThemeMode.system => Icons.brightness_auto,
                }),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListenableBuilder(
                listenable: controller,
                builder: (context, _) {

                  if (controller.state == ControllerState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.list.isEmpty) {
                    return const Center(child: Text('Nenhum lançamento encontrado.\nAdicione um novo lançamento para começar.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)));
                  }

                  return ListView(
                    children: List.generate(
                      controller.list.length,
                      (index) => AppCardAlt(
                        placa: controller.list[index].placa ?? '',
                        data: _dateFormatter.format(
                          controller.list[index].data,
                        ),
                        valor: _currencyFormatter.format(
                          controller.list[index].valor,
                        ),
                        cicloLabel: controller.list[index].ciclo.label,
                        cicloColor: controller.list[index].ciclo.color,
                        onDelete: () async {
                          if (await confirm(
                            'Deseja excluir este lançamento?',
                          )) {
                            controller.delete(controller.list[index].id);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          controller.create(await showModal(const LancamentoCrud()));
        },
        icon: const Icon(Icons.add),
        label: const Text('Adicionar'),
      ),
    );
  }

  void _toggleTheme() {
    theme.toggleTheme();
  }
}
