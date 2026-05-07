import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:julio_app/components/app_card/app_card.dart';
import 'package:julio_app/components/app_card/app_card_alt.dart';
import 'package:julio_app/core/base_state.dart';
import 'package:julio_app/core/system_theme.dart';
import 'package:julio_app/services/lancamento_repository.dart';
import 'package:julio_app/view/home/home_controller.dart';
import 'package:julio_app/view/lancamento/crud/lancamento_crud.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> {

  late final HomeController controller;
  late final SystemTheme theme;

  final _dateFormatter = DateFormat('dd/MM/yyyy');
  final _currencyFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  @override
  void onInit() {
    controller = HomeController(repository: LancamentoRepository(context.read()));
    theme = context.watch<SystemTheme>();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lançamentos'), actions: [
        ListenableBuilder(
          listenable: theme,
          builder: (context, _) {
            return IconButton(
              onPressed: _toggleTheme,
              icon: Icon(theme.theme == ThemeMode.dark ? Icons.brightness_7 : Icons.brightness_6_outlined),
            );
          }
        )
      ],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: List.generate(
                  controller.list.length,
                  (index) => AppCardAlt(
                    placa: controller.list[index].placa ?? '',
                    data: _dateFormatter.format(controller.list[index].data),
                    valor: _currencyFormatter.format(controller.list[index].valor),
                    onDelete: () => controller.list.removeAt(index),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModal(const LancamentoCrud()),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _toggleTheme() {
    var systemTheme = context.read<SystemTheme>();
    systemTheme.toggleTheme();
  }
}
