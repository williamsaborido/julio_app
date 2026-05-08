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
    controller = Controller(
      repository: LancamentoRepository(context.read()),
    );
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
                }
                ),
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
                  return ListView(
                    children: List.generate(
                      controller.list.length,
                      (index) => AppCardAlt(
                        placa: controller.list[index].placa ?? '',
                        data: _dateFormatter.format(controller.list[index].data),
                        valor: _currencyFormatter.format(
                          controller.list[index].valor,
                        ),
                        onDelete: () => controller.list.removeAt(index),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModal(const LancamentoCrud()),
        icon: const Icon(Icons.add),
        label: const Text('Adicionar'),
      ),
    );
  }

  void _toggleTheme() {
    theme.toggleTheme();
  }
}
