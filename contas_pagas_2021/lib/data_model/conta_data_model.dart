
class ContaDataModel{

  static final String TABELA = "tabelaConta";
  static final String id = "id";
  static final String valor = "valor";
  static final String imageFile = "imageFile";
  static final String dataHora = "dataHora";


   static String queryCriarTabela = "";

   static String criarTabela() {

    queryCriarTabela = "CREATE TABLE " + TABELA;
    queryCriarTabela += "(";
    queryCriarTabela += id + " INTEGER PRIMARY KEY, ";
    queryCriarTabela += valor + " REAL, ";
    queryCriarTabela += imageFile + " BLOB, ";
    queryCriarTabela += dataHora + " DATETIME ";
    queryCriarTabela += ");";

    return queryCriarTabela;
  }

   static String dropDatabase(){
    return   "DROP TABLE IF EXISTS "+ TABELA + ";";
  }

   static String zerarTabela() {

    //queryCriarTabela = "DELETE FROM " + TABELA +";";

    return "0";// queryCriarTabela;
  }

   static String getTabela(){
    return TABELA;
  }
}

