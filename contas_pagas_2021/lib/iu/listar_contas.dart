
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagamento_de_contas/utils/core/app_colors.dart';
import 'package:pagamento_de_contas/utils/core/app_gradients.dart';
import 'package:pagamento_de_contas/utils/core/app_text_styles.dart';
import 'package:pagamento_de_contas/helper/db_helper.dart';
import 'package:pagamento_de_contas/iu/cadastrar_conta.dart';
import 'package:pagamento_de_contas/menu/menu_conta.dart';
import 'package:pagamento_de_contas/models/conta.dart';
import 'package:pagamento_de_contas/utils/metods/utils.dart';

class Listar_Contas extends StatefulWidget {
  @override
  _Listar_ContasState createState() => _Listar_ContasState();
}

class _Listar_ContasState extends State<Listar_Contas> {

  Image image;
  List<Conta> _contas = [];
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

                          return Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
                            child: Container(
                              height: 136,
                                decoration: BoxDecoration(
                                  gradient: AppGradients.nuvem,
                                  border: Border.all(
                                    color: AppColors.border
                                  ),
                                borderRadius: BorderRadius.circular(10),
                                ),
                                child:
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(

                                        crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                              width: 80.0,
                                              height: 80.0,
                                              child: Utils.imageFromBase64String(conta.imageFile),

                                            ),
                                        ),

                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text("Tipo: ${conta.tipo.descricao_tipo}",
                                                    style: AppTextStyles.heading),
                                                  Text("Data: ${Utils.formatarData(conta.dataHora, 1)}",
                                                    style: AppTextStyles.heading15),
                                                  Text("Valor: ${conta.valor.toString()}",
                                                    style: AppTextStyles.heading15),
                                                ],
                                              ),
                                          ),
                                        ),


                                     /******************MENU CARD*****************/

                                     /*   PopupMenuButton(
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
                                        )*/
                              ],
                            ),
                                ),

                            ),
                          );
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































