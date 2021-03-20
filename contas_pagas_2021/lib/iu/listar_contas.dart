
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pagamento_de_contas/helper/db_helper.dart';
import 'package:pagamento_de_contas/models/conta.dart';
import 'package:pagamento_de_contas/utils/utils.dart';

class Listar_Contas extends StatefulWidget {
  @override
  _Listar_ContasState createState() => _Listar_ContasState();
}

class _Listar_ContasState extends State<Listar_Contas> {

  Future<File> _imageFile;
  Image image;
  List<Conta> _contas = List<Conta>();
  DBHelper _db = new DBHelper();

  @override
  void initState() {
    super.initState();
    _getContas();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        //key: _scaffoldKey,
        appBar: AppBar(
        title: Text("Lista de Pagamentos"),
        backgroundColor: Colors.teal,
        centerTitle: true,
    ),

    body:  Center(
      child: Column(
              children: <Widget>[

                Expanded(
                    child:

                    ListView.builder(

                          padding: const EdgeInsets.all(55),
                        itemCount: _contas.length,
                          itemBuilder: (context, index){
                          final conta = _contas[index];
                          Utils.imageFromBase64String(conta.imageFile);

                          return Card(

                          shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(color: Colors.redAccent, width: 2),

                          ),
                          child:
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[

                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Utils.imageFromBase64String(conta.imageFile),
                                   ),




                                    Padding(
                                      padding: const EdgeInsets.only(left: 150.0),
                                      child:

                                      ListTile(
                                        title: Text("Data: ${Utils.formatarData(conta.dataHora, 1)}",
                                                    style: TextStyle(
                                                      fontSize: 18.0
                                                    ),),
                                        subtitle: Text("Valor: ${conta.valor.toString()}",
                                                        style: TextStyle(
                                                        fontSize: 18.0
                                                        ),),

                                      ),

                                    ),Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                          onTap: (){},

                            child:  Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Icon(

                                Icons.edit,
                                color: Colors.blueAccent,

                              ),
                            ),),
                                          GestureDetector(
                                            onTap: (){},

                                            child:  Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(

                                                Icons.delete,
                                                color: Colors.redAccent,

                                              ),
                                            ),),        ],
                                      ),
                                    )
                                  ],
                                ),
                              )

                          );
                          }
                      ))
              ],
            ),
    )
     );


  }

  _getContas() async {


    List contasRecuperadas = await _db.getContas();
    List<Conta> contasTemporarias = List<Conta>();
    for(var item in contasRecuperadas){
      Conta c = Conta.fromMap(item);
      contasTemporarias.add(c);
    }
  setState(() {
  _contas = contasTemporarias;
  });
    print(_contas);
  contasTemporarias = null;
  }

}































