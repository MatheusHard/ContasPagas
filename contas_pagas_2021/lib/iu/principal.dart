import 'package:flutter/material.dart';
import 'package:pagamento_de_contas/iu/widgets/cards/card_inicio.dart';
import 'package:pagamento_de_contas/utils/core/app_colors.dart';
import 'package:pagamento_de_contas/utils/core/app_images.dart';
import 'package:pagamento_de_contas/iu/widgets/appbar/app_bar_widget.dart';
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
  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
  child:   GridView.count(

              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,

              children: <Widget>[

                      Card_Principal(icone: Icons.attach_money_sharp, texto: "Cadastrar", cor: AppColors.green, index: 0,),
                      Card_Principal(icone: Icons.text_snippet_sharp, texto: "Histórico", cor: AppColors.lightRed, index: 1,)

                              ],
                  ),
              )
         );

  }
}
