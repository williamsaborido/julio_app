base class Table {
  final int id;

  Table({required this.id});

  /// Converte o objeto em um Map para o banco de dados
  Map<String, dynamic> toMap() {
    throw UnimplementedError('O método toMap deve ser implementado na subclasse');
  }
}
