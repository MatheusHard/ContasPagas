

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagamento_de_contas/helper/db_helper.dart';
import 'package:pagamento_de_contas/models/conta.dart';
import 'package:pagamento_de_contas/models/tipo.dart';
import 'package:pagamento_de_contas/utils/utils.dart';

class Cadastrar_Conta extends StatefulWidget {
  @override
  _Cadastrar_ContaState createState() => _Cadastrar_ContaState();
}

class _Cadastrar_ContaState extends State<Cadastrar_Conta> {

  DBHelper _db = new DBHelper();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Tipo> _listaTipos = List<Tipo>();

  File _imageFile;
  DateTime _dateTime;
  final _valorController = TextEditingController();
  final _dataController = TextEditingController();

  double _valorConta;
  String _descricaoTipo;
  int _idTipo;
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
    getTiposContas();
    super.initState();

  }

  /************DropDown Tipo de Conta************/

  List<DropdownMenuItem<Tipo>> _dropdownMenuItemsTipos;
  Tipo _selectedTipo = null;

  List<DropdownMenuItem<Tipo>> buildDropdownMenuItemsTipos (List tipos){
    List<DropdownMenuItem<Tipo>> items = List();
    for(Tipo tipo in tipos){
      items.add(
          DropdownMenuItem(

            value: tipo,
            child: Center(
              child: _validarTextoDropdownTipo(tipo.id, tipo.descricao_tipo),
                //        child: _validarTextoDropdownCidade(cidade.id, cidade.descricao_cidade.toUpperCase() +"/"+ cidade.uf.descricao_uf.toUpperCase()),
               ),
            ),

      );

    }
    return items;
  }

  onChangedDropdownItemTipo(Tipo selectedTipo){
    setState(() {
      _selectedTipo = selectedTipo;
    });
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

               /********DROP TIPOS*********/
               Padding(
                   padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                   child:

                   InputDecorator(

                     decoration: InputDecoration(

                         border: InputBorder.none,
                         icon: Icon(Icons.phonelink),
                         labelText: "Tipos de Contas",
                         labelStyle: TextStyle(
                             color: Colors.black38,
                             fontSize: 15.0,
                             fontWeight: FontWeight.bold
                         )
                     ),
                     child:
                     DropdownButton(

                         style: TextStyle(inherit: false, color: Colors.white, decorationColor: Colors.white),

                         hint: Text("Selecione o Tipo de Conta"),
                         isExpanded: true,
                         value: _selectedTipo,
                         items: _dropdownMenuItemsTipos,
                         onChanged: onChangedDropdownItemTipo),
                   )),

               /*********FIM DROP**********/

               SizedBox(height: 20.0,),

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
                   /*   if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date.value = TextEditingValue(
            text: formatter.format(
                picked));//Use formatter to format selected date and assign to text field
      });
    return _date;
  }      */

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
    _idTipo = _selectedTipo.id;
    //_idTipo = 2;
    print(_idTipo.toString());

    setState(() {
      if (_imageFile != null){
         /* && _dataController.value.toString() != ""
          && _dataController.value.toString() != ""
            */
if(_valorController.value.text.toString() != "" && _valorController.value.text.toString() != null) {
  _valorConta = double.parse(_valorController.text);
  file = Utils.base64String(_imageFile.readAsBytesSync());
  _db.insertConta(new Conta(_valorConta, _dateTime.toString(), file, _idTipo, null));

  clearControllers();
  Utils.showDefaultSnackbar(_scaffoldKey, "Cadastro realizado com sucesso!!!");
}else{
  Utils.showDefaultSnackbar(_scaffoldKey, "Digite o valor!!! ");

}
    }else{
    Utils.showDefaultSnackbar(_scaffoldKey, "Foto obrigatória!!! ");

    }
    });
    //int res = await _db.insertConta(new Conta(_valorConta, _dateTime.toString(), file));



    /*if(res > 0){
    Utils.showDefaultSnackbar(_scaffoldKey, "Cadastro realizado com sucesso!!!");
    }else{
      Utils.showDefaultSnackbar(_scaffoldKey, "Não foi possível realizar o cadastro");
    }*/

  }

  clearControllers(){
    _valorController.clear();
    _dataController.clear();
  }

  getTiposContas() async{

    DBHelper db = new DBHelper();
    List tipos = await db.getTipos();
    List<Tipo> listaTemporaria = [];
    for(var tipo in tipos){
      Tipo t = Tipo.fromMap(tipo);
      listaTemporaria.add(t);
    }
    setState(() {
      _listaTipos = listaTemporaria;
      _dropdownMenuItemsTipos = buildDropdownMenuItemsTipos(_listaTipos);
      _selectedTipo = _dropdownMenuItemsTipos[0].value;
    });
    listaTemporaria = null;
    print(_listaTipos.toString());

  }


  Text _validarTextoDropdownTipo(int id, String texto){

    if(id == 1) {
      texto = "ESCOLHA UMA OPÇÃO".toUpperCase();
      return Text(
        texto.toUpperCase(),
        style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.red,
            fontSize: 15.0
        ),);

    }else{
      return Text(
        texto.toUpperCase(),
        style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.red,
            fontSize: 15.0
        ),);
    }
  }


}
