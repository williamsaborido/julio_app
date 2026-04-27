import 'package:flutter/material.dart';
import 'package:julio_app/components/app_card/app_card.dart';
import 'package:julio_app/core/base_state.dart';
import 'package:julio_app/core/system_theme.dart';
import 'package:julio_app/view/lancamento/crud/lancamento_crud.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lançamentos'), actions: [
        IconButton(
          onPressed: _toggleTheme,
          icon: const Icon(Icons.brightness_6_outlined),
        )
      ],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: List.generate(
                  10,
                  (index) => AppCard(
                    placa: 'ABC1234',
                    data: '01/01/2024',
                    valor: 'R\$ 100,00',
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
