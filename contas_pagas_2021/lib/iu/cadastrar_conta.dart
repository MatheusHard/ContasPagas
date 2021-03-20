

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagamento_de_contas/helper/db_helper.dart';
import 'package:pagamento_de_contas/models/conta.dart';
import 'package:pagamento_de_contas/utils/utils.dart';

class Cadastrar_Conta extends StatefulWidget {
  @override
  _Cadastrar_ContaState createState() => _Cadastrar_ContaState();
}

class _Cadastrar_ContaState extends State<Cadastrar_Conta> {

  DBHelper _db = new DBHelper();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  File _imageFile;
  DateTime _dateTime;
  final _valorController = TextEditingController();
  final _dataController = TextEditingController();

  double _valorConta;
  //String _dataConta = Utils.formatarData(Utils.getDataHora().toString(), 1);




  _openCamera() async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      _imageFile = picture;
    });
  }


  Widget _decideImageView (){
    if(_imageFile == null){
      return  Image.asset("assets/no_camera_icon.png",
        height: 200.0,
        width: 200.0,
      );
    }else{
      return
     Image.file(_imageFile, width: 200, height:  200,);
    }
  }

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
        title: Text("Cadastrar Conta"),
        centerTitle: true,
      ),

       body: Center(

         child:  SingleChildScrollView(

           child: Column(
             children: <Widget>[

               GestureDetector(
                 onTap: () {
                   _openCamera();
                 },
                 child:

                 ClipRRect(
                   child: _decideImageView(),
                   borderRadius: BorderRadius.circular(10.0),

                 )
               ),

               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextField(

                   keyboardType: TextInputType.number,
                   controller: _valorController,

                   decoration: InputDecoration(
                       border: OutlineInputBorder(),
                       hintText: 'Valor',
                       icon: Icon(Icons.attach_money, color: Colors.greenAccent,)
                   ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextField(
                   readOnly: true,

                   onTap: (){
                     FocusScope.of(context).requestFocus(new FocusNode());

                     showDatePicker(
                         context: context,
                         initialDate: DateTime.now(),
                         firstDate: DateTime(2000),
                         lastDate: DateTime(2030)
                     ).then((date){
                       setState(() {
                         _dateTime = date;
                         _dataController.value = TextEditingValue(text:  Utils.formatarData(_dateTime.toString(),1) );

                       });
                     });
                   },

                   keyboardType: TextInputType.datetime,
                   controller: _dataController,
                   decoration: InputDecoration(
                       icon: Icon(Icons.date_range),
                       border: OutlineInputBorder(),
                       hintText :  "Digite o vecimento",

                     //icon:
                   ),
                     ),

               ),
             /*  IconButton(
                   icon:
                   Icon(Icons.date_range),
                        onPressed: (){
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2030)
                          ).then((date){
                            setState(() {
                              _dateTime = date;
                            });
                          });
                        }),*/
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ButtonTheme(
                   minWidth: double.infinity,
                   child: RaisedButton(

                     child: Text("SALVAR", style: TextStyle(
                       fontSize: 20.0,
                       fontStyle: FontStyle.italic,
                     ),),
                     onPressed: () {
                       _cadastrarConta();
                     } ,
                     textColor: Colors.white,
                     color: Colors.black12,

                   ),
                 ),
               )
             ],
           ),
         )
       )
    );



    }
  _cadastrarConta() async{

    String file;
    setState(() {
      _valorConta = double.parse(_valorController.text);
//      _dataConta = Utils.getDataHora().toString();
      file = Utils.base64String(_imageFile.readAsBytesSync()) ;

     clearControllers();

    });
    int res = await _db.insertConta(new Conta(_valorConta, _dateTime.toString(), file));



    if(res > 0){
    Utils.showDefaultSnackbar(_scaffoldKey, "Cadastro realizado com sucesso!!!");
    }else{
      Utils.showDefaultSnackbar(_scaffoldKey, "Não foi possível realizar o cadastro");
    }

  }

  clearControllers(){
    _valorController.clear();
    _dataController.clear();
  }

}
