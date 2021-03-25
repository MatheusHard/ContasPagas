
import 'dart:io';
import 'dart:typed_data';

import 'package:card_settings/card_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagamento_de_contas/data_model/conta_data_model.dart';
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

                          return

                          Card(
                            color: Colors.grey[800],
                            clipBehavior: Clip.antiAlias,
                              shadowColor: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(color: Colors.grey, width: 2),

                          ),
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                          Padding(

                            padding: const EdgeInsets.only(left: 150.0),

                            child: ListTile(

                              leading: Icon(Icons.attach_money_rounded),
                                title: const Text('Conta', style: TextStyle(
                                color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25
                                ),),


                            ),
                          ),

                              Divider(color:
                              Colors.grey, height: 20,
                                thickness: 1,
                                indent: 0,
                                endIndent: 0,),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 90.0,
                                        height: 90.0,
                                        child: Utils.imageFromBase64String(conta.imageFile),

                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text("Tipo: ${conta..toString()}",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white
                                            ),),
                                          Text("Data: ${Utils.formatarData(conta.dataHora, 1)}",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white
                                            ),),
                                          Text("Valor: ${conta.valor.toString()}",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white
                                            ),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ButtonBar(
                                children: [


                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: GestureDetector(

                                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Listar_Contas())), // handle your image tap here
                                      child:
                                      Image.asset("assets/edit.png",
                                        height: 40.0,
                                        width: 40.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: GestureDetector(

                                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Listar_Contas())), // handle your image tap here
                                      child:
                                      Image.asset("assets/del.png",
                                        height: 40.0,
                                        width: 40.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),

                              /*Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[

                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Utils.imageFromBase64String(conta.imageFile),
                                   ),


                                    Divider(color:
                                      Colors.grey, height: 20,
                                      thickness: 1,
                                      indent: 0,
                                      endIndent: 0,),

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
                              )*/

                          );
                          }
                      ))
              ],
            ),
    )
     );


  }

  _getContas() async {

   print( ContaDataModel.getAtributos());
    List contasRecuperadas = await _db.getContas();
    List<Conta> contasTemporarias = List<Conta>();
    for(var item in contasRecuperadas){
      Conta c = Conta.fromMap(item);
      contasTemporarias.add(c);
    }
  setState(() {
  _contas = contasTemporarias;
 // print(_contas);
  });
   // print(_contas);
  contasTemporarias = null;
  }

}































