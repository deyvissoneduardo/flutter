/*
 * Essa classe utiliza o padrao singleton
 */
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AnotacaoHelper {
  String _nomeBanco = "banco_minhas_anotacoes.db";
  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();
  Database _db;

  factory AnotacaoHelper() {
    return _anotacaoHelper;
  }

  AnotacaoHelper._internal() {}

  /*
   * metodo que inicializa o banco
   */
  inicializarDB() async {
    final caminhoDataBase = await getDatabasesPath();
    final localDatabase = join(caminhoDataBase, _nomeBanco);

    var db =
        await openDatabase(localDatabase, version: 1, onCreate: _onCreate());
    return db;
  }

  _onCreate(Database db, int version) async {
    String sql = 'CREATE TABLE anotacao ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'titulo VARCHAR, '
        'descricao TEXT, '
        'data DATETIME)';
    await db.execute(sql);
  }

  /*
   * retorna a instacia do banco de dados
   * caso nao tenha, cria uma nova
   */
  get db async {
    if (_db != null) {
      return _db;
    } else {}
  }
}
