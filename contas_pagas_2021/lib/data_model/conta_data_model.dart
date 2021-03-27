
class ContaDataModel{

  static final String TABELA = "tabelaConta";
  static final String id = "id";
  static final String valor = "valor";
  static final String imageFile = "imageFile";
  static final String dataHora = "dataHora";
  static final String tipoId = "tipo_id";

   static String queryCriarTabela = "";

   static String criarTabela() {

    queryCriarTabela = "CREATE TABLE " + TABELA;
    queryCriarTabela += "(";
    queryCriarTabela += id + " INTEGER PRIMARY KEY, ";
    queryCriarTabela += valor + " REAL, ";
    queryCriarTabela += imageFile + " TEXT, ";
    queryCriarTabela += dataHora + " DATETIME, ";
    queryCriarTabela += tipoId + " INTEGER ";
    queryCriarTabela += ");";

    return queryCriarTabela;
  }

   static String dropDatabase(){
    return   "DROP TABLE IF EXISTS $TABELA;";
  }

   static String zerarTabela() {

    return "DELETE FROM $TABELA;";
  }

   static String getTabela(){
    return TABELA;
  }

  static String getAtributos(){
     return "$TABELA.id, $TABELA.valor, $TABELA.imageFile, $TABELA.dataHora, $TABELA.tipo_id";
    //return "$TABELA.id, $TABELA.valor, $TABELA.dataHora, $TABELA.tipo_id";
  }
}

