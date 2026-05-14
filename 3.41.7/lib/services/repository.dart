import 'package:julio_app/services/database.dart';
import 'package:julio_app/models/table.dart';

abstract base class Repository<T extends Table> {
  final Database _database;

  Repository(this._database);

  /// Getter abstrato que deve retornar o nome da tabela no banco
  String get tableName;

  /// Método abstrato que deve converter um Map em uma instância de T
  T fromMap(Map<String, dynamic> map);

  /// Deleta um registro pelo ID
  Future<int> delete(int id) async {
    return await _database.delete(tableName, id);
  }

  /// Obtém um registro pelo ID
  Future<T?> get(int id) async {
    final map = await _database.get(tableName, id);
    if (map != null) {
      return fromMap(map);
    }
    return null;
  }

  /// Obtém uma lista de registros com ordenação e paginação
  Future<List<T>> getList([
    String order = 'id',
    bool orderAsc = true,
    int pageIndex = 1,
    int pageSize = 50,
    bool withPagination = true,
  ]) async {
    final maps = await _database.query(
      tableName,
      orderBy: '$order ${orderAsc ? 'ASC' : 'DESC'}',
      limit: withPagination ? pageSize : null,
      offset: withPagination ? (pageIndex - 1) * pageSize : null,
    );

    return maps.map((map) => fromMap(map)).toList();
  }

  /// Cria um novo registro
  Future<int> create(T data) async {
    return await _database.insert(tableName, data.toMap());
  }

  /// Atualiza um registro existente
  Future<int> update(T data) async {
    return await _database.update(
      tableName,
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  
}
