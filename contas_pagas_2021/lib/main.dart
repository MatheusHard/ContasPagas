import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pagamento_de_contas/helper/db_helper.dart';
import 'package:pagamento_de_contas/iu/principal.dart';
import 'package:pagamento_de_contas/models/conta.dart';
import 'package:pagamento_de_contas/utils/utils.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  DBHelper db = new DBHelper();
//  DateTime data = Utils.getDataHora();
//  File i = Image.asset("assets/no_camera_icon.png");
  //int a = await db.insertConta(new Conta(100.0,  data, i));
  //print(a);

  /*List list = await db.getContas();
  for(var conta in list){
    print("Conta: "+ conta.toString());
  }*/
  //File i = Image.asset("assets/no_camera_icon.png");
  //var data3 = data.toString();





  runApp(
    MaterialApp(
      home: Principal(),
    )

  );
}
