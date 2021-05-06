

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagamento_de_contas/utils/core/app_colors.dart';
import 'package:pagamento_de_contas/utils/core/app_images.dart';
import 'package:pagamento_de_contas/utils/core/app_text_styles.dart';
import 'package:pagamento_de_contas/helper/db_helper.dart';
import 'package:pagamento_de_contas/models/conta.dart';
import 'package:pagamento_de_contas/models/tipo.dart';
import 'package:pagamento_de_contas/utils/metods/utils.dart';


class Cadastrar_Conta extends StatefulWidget {

  /****PASSAR OBJETO PELO CONSTRUTOR*****/
  final Conta conta;
  Cadastrar_Conta({Key key, @required this.conta}): super(key: key);

  @override
  _Cadastrar_ContaState createState() => _Cadastrar_ContaState(conta);
}

class _Cadastrar_ContaState extends State<Cadastrar_Conta> {

  FocusNode _myFocusNode;
  FocusNode _myFocusNode_2;
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
    _myFocusNode = FocusNode();
    _myFocusNode_2 = FocusNode();
    super.initState();

  }

  /************DropDown Tipo de Conta************/

  List<DropdownMenuItem<Tipo>> _dropdownMenuItemsTipos;
  Tipo _selectedTipo;

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
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25),
             child: Center(

                 child:  SingleChildScrollView(

                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,

                     children: <Widget>[

                      Container(
                        decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15, top: 20),
                              child: Text("Cadastre a Imagem da Conta",
                                  style: AppTextStyles.heading25),
                            ),

                            getImageWidget(),

                            ///***********************/
                            Row(
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
                                Expanded(
                                    child:
                                    MaterialButton(
                                      child:   Image.asset(AppImages.icons_gallery_80,
                                        height: 200.0,
                                        width: 200.0,
                                      ),
                                      onPressed: (){
                                        _getImage(ImageSource.gallery);
                                      },
                                    )

                                )
                              ],

                            ),
                          ],
                        ),
                      ),




                       /********DROP TIPOS*********/

                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 10),
                             child: InputDecorator(
                               decoration: InputDecoration(
                                   border: InputBorder.none,
                                   icon: Icon(Icons.phonelink),
                                   labelText: "Tipos de Contas",
                                   labelStyle: AppTextStyles.heading15
                               ),
                               child:
                               DropdownButton(

                                   style: TextStyle(inherit: false, color: Colors.white, decorationColor: Colors.white),
                                   hint: Text("Selecione o Tipo de Conta"),
                                   isExpanded: true,
                                   value: _selectedTipo,
                                   items: _dropdownMenuItemsTipos,
                                   onChanged: onChangedDropdownItemTipo),
                             ),
                           ),

                       /*************VALOR*************/

                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                         child: TextField(

                           keyboardType: TextInputType.number,
                           controller: _valorController,
                           focusNode: _myFocusNode,
                           decoration: InputDecoration(
                               hintText: 'Valor',
                               icon: Icon(Icons.attach_money, color: Colors.green,)
                           ),
                         ),
                       ),

                       /*************DATA_HORA*************/
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                             hintText :  "Digite o vecimento",
                           ),
                         ),

                       ),
                      SizedBox(width: 30,height: 30,),

                       /*********BUTTON CADASTRAR*********/

                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                         child: Center(
                           child: ElevatedButton(
                            onPressed: () {
                              _cadastrarConta();
                         },
                          style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                           child: Ink(

                                decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
                                borderRadius: BorderRadius.circular(20)),
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.save_rounded),
                                    Container(
                                      width: 200,
                                      height: 50,
                                      alignment: Alignment.center,
                                      child:

                                      Text(
                                        'Cadastrar',
                                        style: AppTextStyles.titleBold,
                                      ),


                                    ),
                                  ],)

                      ),
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
