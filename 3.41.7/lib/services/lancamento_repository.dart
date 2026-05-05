import 'package:julio_app/models/lancamento.dart';
import 'package:julio_app/services/repository.dart';

final class LancamentoRepository extends Repository<Lancamento> {
  LancamentoRepository(super.database);

  @override
  String get tableName => 'lancamento';

  @override
  Lancamento fromMap(Map<String, dynamic> map) => Lancamento.fromMap(map);
}
