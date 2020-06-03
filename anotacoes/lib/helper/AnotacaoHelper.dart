/*
 * Essa classe utiliza o padrao singleton
 */
import 'package:anotacoes/model/Anotacao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AnotacaoHelper {
  static final String _nomeBanco = "banco_minhas_anotacoes.db";
  static final String _nomeTabela = 'anotacao';
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

    var db = await openDatabase(localDatabase, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    String sql = 'CREATE TABLE $_nomeTabela ('
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
    } else {
      _db = await inicializarDB();
      return _db;
    }
  }

  /*
   * salva automaticamente no banco
   */
  Future<int> salvarAnotacao(Anotacao anotacao) async {
    var bancoDados = await db;
    int resultado = await bancoDados.insert(_nomeTabela, anotacao.toMap());
    return resultado;
  }

  /*
   * recupera coluna do banco de dados
   */
  recuperaAnotacao() async {
    var bancoDados = await db;
    String sql = 'SELECT * FROM $_nomeTabela ORDER BY data DESC';
    List anotacoes = await bancoDados.rawQuery(sql);
    return anotacoes;
  }

  /*
   * atualiza anotacao
   */
  Future<int> atulizarAnotacao(Anotacao anotacao) async {
    var bancoDados = await db;
    return await bancoDados.update(_nomeTabela, anotacao.toMap(),
        where: "id = ?", whereArgs: [anotacao.id]);
  }

  /*
   * remove anotacao
   */
  Future<int> removeAnotacao(int id) async {
    var bancoDados = await db;
   return await bancoDados.delete(_nomeTabela, where: "id = ?", whereArgs: [id]);
  }
}
