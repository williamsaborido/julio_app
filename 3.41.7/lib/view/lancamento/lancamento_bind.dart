import 'package:flutter/material.dart';
import 'package:julio_app/services/lancamento_repository.dart';
import 'package:julio_app/view/lancamento/home/home_view.dart';
import 'package:provider/provider.dart';

class LancamentoBind extends StatefulWidget {

  const LancamentoBind({ super.key });

  @override
  State<LancamentoBind> createState() => _LancamentoBindState();
}

class _LancamentoBindState extends State<LancamentoBind> {

   @override
   Widget build(BuildContext context) {
       return Provider(create: (_) => LancamentoRepository(context.read()), child: const HomeView());
  }
}