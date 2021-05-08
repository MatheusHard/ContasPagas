import 'package:flutter/material.dart';


class Card_Imagem extends StatefulWidget {
  IconData icone;
  String texto;
  Color cor;
  int index;

  Card_Imagem({Key key, @required this.icone, @required this.texto,
    @required this.cor, @required this.index}) : super(key: key);

  @override
  _Card_ImagemState createState() => _Card_ImagemState(icone, texto, cor, index);
}

class _Card_ImagemState extends State<Card_Imagem> {

  IconData _icon;
  String _texto;
  Color _cor;
  int _index;

  _Card_ImagemState(IconData icon, String texto, Color cor, int index){
    this._icon = icon;
    this._texto = texto;
    this._cor = cor;
    this._index = index;
  }


  @override
  Widget build(BuildContext context) {


    final pages = [
      _Card_ImagemState(conta: null,),
      Listar_Contas()
    ];

    return


      GestureDetector(

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
                _icon,
                color: this._cor,
                size: 50,),),

              Align(
                  alignment: Alignment(0, 2.5),
                  child:
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 50),
                    child: Text(this._texto, style: AppTextStyles.bodyBold,),
                  ))
            ],
          ),
        ),

        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pages[_index])), //
      );


  }
}
