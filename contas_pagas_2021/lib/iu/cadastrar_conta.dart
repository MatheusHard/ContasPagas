

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagamento_de_contas/core/app_images.dart';
import 'package:pagamento_de_contas/helper/db_helper.dart';
import 'package:pagamento_de_contas/models/conta.dart';
import 'package:pagamento_de_contas/models/tipo.dart';
import 'package:pagamento_de_contas/utils/utils.dart';


class Cadastrar_Conta extends StatefulWidget {

  /****PASSAR OBJETO PELO CONSTRUTOR*****/
  final Conta conta;
  Cadastrar_Conta({Key key, @required this.conta}): super(key: key);

  @override
  _Cadastrar_ContaState createState() => _Cadastrar_ContaState(conta);
}

class _Cadastrar_ContaState extends State<Cadastrar_Conta> {

  File _selectedFile;
  Conta _conta;
  DBHelper _db = new DBHelper();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Tipo> _listaTipos = [];
  final _valorController = TextEditingController();
  final _dataController = TextEditingController();
  final _picker = ImagePicker();

/********RECEBENDO DO CONTRUTOR************/

  _Cadastrar_ContaState(Conta conta){
  this._conta = conta;
  if(_conta != null){
    _valorController.text = _conta.valor.toString();
    //_dataController.text = Utils.formatarData(_dataController.text = _conta.dataHora, 1) ;
    _dataController.text = _conta.dataHora;
    _dateTime = DateTime.parse(_conta.dataHora);
  }
   // _selectedFile = Utils.imageFromBase64String(conta.imageFile);


  }

  bool _inProcess = false;

  DateTime _dateTime;

  double _valorConta;
  int _idTipo;

  /*_openCamera( ) async{
   var picture = await ImagePicker.pickImage(
                                            source: ImageSource.camera,
                                            maxHeight: 480,
                                            maxWidth: 640,
                                            imageQuality: 50 );

    this.setState((){
      _imageFile = picture;
    });
  }*/

  /**************TESTES GET IMAGE*******************/

  Widget getImageWidget(){
    if(_selectedFile != null){
      return Image.file(
        _selectedFile,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }else{
      return Image.asset(
        AppImages.no_camera_icon,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }
  }

  Future _getImage(ImageSource source) async{
    final pickedFile = await _picker.getImage(

        source: source,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50 );
    this.setState(() {
      if (pickedFile != null) {
        _selectedFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    /* File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });*/

    /*if(image != null){
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1,
              ratioY: 1),
          compressQuality: 50,
          maxWidth: 500,
          maxHeight: 500,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.deepOrange,
              toolbarTitle: "RPS Cropper",
              statusBarColor: Colors.deepOrange.shade900,
              backgroundColor: Colors.white
          )
      );
      this.setState(() {
        _selectedFile = cropped;
       // _inProcess = false;
      });
    } else {
      this.setState(() {
        //_inProcess = false;
      });
    }*/



  }


  ///**************************************************/


  @override
  void initState() {
    getTiposContas();
    super.initState();

  }

  /************DropDown Tipo de Conta************/

  List<DropdownMenuItem<Tipo>> _dropdownMenuItemsTipos;
  Tipo _selectedTipo = null;

  List<DropdownMenuItem<Tipo>> buildDropdownMenuItemsTipos (List tipos){
    List<DropdownMenuItem<Tipo>> items = [];
    for(Tipo tipo in tipos){
      items.add(
          DropdownMenuItem(

            value: tipo,
            child: Center(
              child: _validarTextoDropdownTipo(tipo.id, tipo.descricao_tipo),
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
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Cadastrar Conta"),
        centerTitle: true,
      ),

       body: Stack(
         children: [
           Center(

               child:  SingleChildScrollView(

                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,

                   children: <Widget>[

                     Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Text("Cadastre a Imagem da Conta", style:
                         TextStyle(fontSize: 20.0, color: Colors.black26, fontWeight: FontWeight.bold),),
                     ),

                        getImageWidget(),

                    ///***********************/
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                       child: Row(
                         mainAxisAlignment:  MainAxisAlignment.spaceBetween,

                         children: [
                           Expanded(
                               child:
                           GestureDetector(
                             child:    Image.asset(AppImages.icons_camera_100,
                               height: 200.0,
                               width: 200.0,
                             ),
                             onTap: (){
                               _getImage(ImageSource.camera);
                             },
                           )),
                           Expanded(child:
                           MaterialButton(
                             child:   Image.asset(AppImages.icons_gallery_80,
                               height: 200.0,
                               width: 200.0,
                             ),
                             onPressed: (){
                               _getImage(ImageSource.gallery);
                             },
                           )
                             /*GestureDetector(
                             child:    Image.asset("assets/icons_gallery_80.png",
                               height: 200.0,
                               width: 200.0,
                             ),
                             onTap: (){
                               _getImage(ImageSource.gallery);
                             },
                           )*/

                           )
                         ],
                       ),
                     ),
                     ///*************************/
                  /*   GestureDetector(
                         onTap: () {
                           _openCamera();
                         },
                         child:

                         ClipRRect(
                           child: _decideImageView(),
                           borderRadius: BorderRadius.circular(10.0),

                         )
                     ),*/

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
                            //if(_formKey.currentState.validate()) {
                              _cadastrarConta();
                         //   }
                           } ,
                           textColor: Colors.white,
                           color: Colors.black12,

                         ),
                       ),
                     ),
                    /* (_inProcess)?Container(
                       color: Colors.white,
                       height: MediaQuery.of(context).size.height * 0.95,
                       child: Center(
                         child: CircularProgressIndicator(),
                       ),
                     ):Center()*/
                   ],
                 ),

               ),

           )
         ],
       ),

    );



    }
  _cadastrarConta() async{

    String file;
    _idTipo = _selectedTipo.id;
    //_idTipo = 2;
    print(_idTipo.toString());

    setState(() {
     // if (_imageFile != null){
      if(_selectedFile != null){
         /* && _dataController.value.toString() != ""
          && _dataController.value.toString() != ""
            */
if(_valorController.value.text.toString() != "" && _valorController.value.text.toString() != null) {
  _valorConta = double.parse(_valorController.text);
  //file = Utils.base64String(_imageFile.readAsBytesSync());
  file = Utils.base64String(_selectedFile.readAsBytesSync());
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
