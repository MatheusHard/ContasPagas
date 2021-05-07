import 'package:flutter/material.dart';
import 'package:pagamento_de_contas/home/widgets/cards/card_inicio.dart';
import 'package:pagamento_de_contas/utils/core/app_colors.dart';
import 'package:pagamento_de_contas/utils/core/app_images.dart';
import 'package:pagamento_de_contas/home/widgets/appbar/app_bar_widget.dart';
import 'package:pagamento_de_contas/iu/cadastrar_conta.dart';
import 'package:pagamento_de_contas/iu/listar_contas.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
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
                        Image.asset("assets/images/contas.png",
                          height: 50.0,
                         width: 50.0,
                        ),),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Listar_Contas())), // handle your image tap here
                        child:
                            Container(
                              color: Colors.green,
                              child:

                            Image.asset("assets/images/historico.png",
                              height: 50.0,
                              width: 50.0,
                            ),
                        )

                      ),

                      Card_Principal(icone: Icons.attach_money_sharp, texto: "Cadastrar", cor: AppColors.green, index: 0,),
                      Card_Principal(icone: Icons.text_snippet_sharp, texto: "Historico", cor: AppColors.lightRed, index: 1,)

              ],
                ),
              )
         );

  }
}
