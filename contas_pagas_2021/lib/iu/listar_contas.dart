
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagamento_de_contas/helper/db_helper.dart';
import 'package:pagamento_de_contas/iu/cadastrar_conta.dart';
import 'package:pagamento_de_contas/menu/menu_conta.dart';
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

                          padding: const EdgeInsets.all(8.0),
                          itemCount: _contas.length,
                          itemBuilder: (context, index){
                          final conta = _contas[index];

                          return

                          Card(
                            clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(color: Colors.grey, width: 1),

                          ),
                          child:

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
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

                                          Text("Tipo: ${conta.tipo.descricao_tipo}",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                //color: Colors.white
                                            ),),
                                          Text("Data: ${Utils.formatarData(conta.dataHora, 1)}",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                //color: Colors.white
                                            ),),
                                          Text("Valor: ${conta.valor.toString()}",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                               // color: Colors.white
                                            ),),
                                        ],
                                      ),
                                    ),

                                 /******************MENU CARD*****************/

                                    PopupMenuButton(
                                      onSelected: (value){
                                        _choiceAction(value, conta);
                                    } ,
                                      itemBuilder: (BuildContext context){
                                        return MenuItemConta.menuItens.map((e) {
                                          return PopupMenuItem(
                                              value: e,
                                              child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    mainAxisSize: MainAxisSize.min,
                                                 children: [
                                                   Text(e.menuText),
                                                    e.menuIcon
                                                 ],
                                                  )
                                          );
                                        }).toList();
                                      },
                                    )
                            ],
                          ),

                          ));
                          }
                      ))
              ],
            ),
    )
     );


  }

  _getContas() async {

   List contasRecuperadas = await _db.getContasTipos();
   List<Conta> contasTemporarias = [];
    for(var item in contasRecuperadas){
      Conta c = Conta.fromMap(item);
      contasTemporarias.add(c);
    }
  setState(() {
  _contas = contasTemporarias;

  });
  contasTemporarias = null;
  }

   _choiceAction(MenuItemConta value, Conta c) {

    if(value.id == 1){
      print("ESCOLHEU EDITAR");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Cadastrar_Conta(conta: c)),
      );
    }else if(value.id == 2){
      print("ESCOLHEU EXCLUIR");
    }
  }
}































