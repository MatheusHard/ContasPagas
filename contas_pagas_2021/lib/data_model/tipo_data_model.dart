class TipoDataModel{

  static final String TABELA = "tabelaTipo";
  static final String id = "id";
  static final String descricao_tipo = "descricao_tipo";


  static String queryCriarTabela = "";

  static String criarTabela() {

    queryCriarTabela = "CREATE TABLE " + TABELA;
    queryCriarTabela += "(";
    queryCriarTabela += id + " INTEGER PRIMARY KEY, ";
       queryCriarTabela += descricao_tipo + " TEXT ";
    queryCriarTabela += ");";

    return queryCriarTabela;
  }

  static String dropDatabase(){
    return   "DROP TABLE IF EXISTS "+ TABELA + ";";
  }

  static String zerarTabela() {

   return "DELETE FROM " + TABELA +";";

  }

  static String getTabela(){
    return TABELA;
  }

  static String getAtributos(){
    return "$TABELA.id, $TABELA.descricao_tipo";
  }
}

