import 'package:pagamento_de_contas/data_model/conta_data_model.dart';
import 'package:pagamento_de_contas/data_model/tipo_data_model.dart';
import 'package:pagamento_de_contas/models/conta.dart';
import 'package:pagamento_de_contas/models/tipo.dart';
import 'package:pagamento_de_contas/utils/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';





class DBHelper{

  static final DBHelper _instance = new DBHelper.internal();
  factory DBHelper() => _instance;

  static Database _db;

  final String tabelaConta = "tabelaConta";


  /*********ATRIBUTOS*********/

  final String colunaIdConta = "id";
  final String colunaValor = "valor";
  final String colunaImageFile = "imageFile";
  final String colunaDataHora = "dataHora";


  Future<Database> get db async {
    if(_db != null){
      return _db;
    }
    _db = await initBD();
    return _db;
  }

  DBHelper.internal();

  initBD () async {
    Directory documentoDiretorio = await getApplicationDocumentsDirectory();
    String caminho = join(documentoDiretorio.path, "db_contas.db");// home://directory/files/db_avaliacoes.db

    var nossoDB = await  openDatabase(caminho, version: 1, onCreate: _onCreate);
    return nossoDB;
  }

  void _onCreate(Database db, int version) async{

    await db.execute(ContaDataModel.criarTabela());
    await db.execute(TipoDataModel.criarTabela());




  }

  Future<int> insertConta (Conta contaModel) async{
    var dbConta = await db;
    int res = await dbConta.insert(ContaDataModel.getTabela(), contaModel.toMap());
    return res.toInt();
  }

  Future<int> insertTipo(Tipo tipoModel) async{
    var dbTipo = await db;
    int res = await dbTipo.insert(TipoDataModel.getTabela(), tipoModel.toMap());
    return res.toInt();
  }

  Future<List> getTipos () async {

    var dbTipo = await db;
    var res = await dbTipo.rawQuery("SELECT ${TipoDataModel.getAtributos()} FROM ${TipoDataModel.getTabela()} ORDER BY ${TipoDataModel.descricao_tipo}");
    return res.toList();
  }
  Future<List> getContas () async {

    var dbCidade = await db;
    var res = await dbCidade.rawQuery("SELECT ${ContaDataModel.getAtributos()} FROM ${ContaDataModel.getTabela()} ORDER BY ${ContaDataModel.dataHora} DESC");
    return res.toList();
  }

  Future<List> getContasTipos () async {

    var dbContaTipo = await db;
    var res = await dbContaTipo.rawQuery("SELECT ${ContaDataModel.getAtributos()}, ${TipoDataModel.getAtributos()} "
                                         "FROM ${ContaDataModel.getTabela()} INNER JOIN ${TipoDataModel.getTabela()} "
                                         "WHERE ${TipoDataModel.getTabela()}.${TipoDataModel.id} = "
                                         "${ContaDataModel.getTabela()}.${ContaDataModel.tipoId} "
                                         "ORDER BY ${ContaDataModel.dataHora} DESC");

    return res.toList();
  }
}





















