import 'package:flutter/material.dart';
import 'package:pagamento_de_contas/iu/cadastrar_conta.dart';
import 'package:pagamento_de_contas/utils/core/app_colors.dart';
import 'package:pagamento_de_contas/utils/core/app_text_styles.dart';

class Card_Principal extends StatefulWidget {

  const Card_Principal({Key key}) : super(key: key);

  @override
  _Card_PrincipalState createState() => _Card_PrincipalState();
}

class _Card_PrincipalState extends State<Card_Principal> {
  @override
  Widget build(BuildContext context) {
    return


            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastrar_Conta(conta: null,))), // handle your image tap here

              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(20)),
                height: 100,
                width: 100,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [

                    Center(child:
                    Icon(
                      Icons.attach_money_sharp,
                      color: AppColors.green,
                      size: 50,),),

                Align(
                    alignment: Alignment(0, 2.5),
                    child:
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 50),
                        child: Text("Cadastro", style: AppTextStyles.bodyBold,),
                    ))
                  ],
                ),
              ),
            );


  }
}
