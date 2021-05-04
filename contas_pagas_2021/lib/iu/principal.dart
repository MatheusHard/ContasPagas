import 'package:flutter/material.dart';
import 'package:pagamento_de_contas/iu/cadastrar_conta.dart';
import 'package:pagamento_de_contas/iu/listar_contas.dart';
import 'package:pagamento_de_contas/menu/menu_conta.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text("Contas Pagas"),
        actions: <Widget>[
          PopupMenuButton(
              itemBuilder: (BuildContext context){
    return MenuItemConta.menuItens.map((e) {
    return PopupMenuItem<MenuItemConta>(
    value: e,
    child: Text(e.menuText)
    );
    }).toList();
    },
    )

        ],
      ),
      backgroundColor: Colors.white,
      body:
     // Padding(
       // padding: const EdgeInsets.all(15.0),
        //child:

Padding(
  padding: const EdgeInsets.all(50.0),
  child:   GridView.count(

      crossAxisCount: 2,

              childAspectRatio: 1.0,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: <Widget>[

                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastrar_Conta(conta: null,))), // handle your image tap here
                        child:
                        Image.asset("assets/contas.png",
                          height: 50.0,
                         width: 50.0,
                        ),),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Listar_Contas())), // handle your image tap here
                        child:
                        Image.asset("assets/historico.png",
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                    ],
                ),
              )
         );

  }
}
