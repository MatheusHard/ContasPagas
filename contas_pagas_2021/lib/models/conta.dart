
import 'dart:io';

class Conta{
  int _id;
  double _valor;
  String _dataHora;
  String _imageFile;




  Conta(this._valor, this._dataHora, this._imageFile);

  Conta.fromJson(Map<String, dynamic> json):
        this._id = int.tryParse(json['id']) ?? 0,
        this._valor = json['valor'],
        this._dataHora = json['dataHora'],
        this._imageFile = json['imageFile'];

  Map<String, dynamic> toJson() =>
      {
        'valor': this._valor,
        'dataHora': this._dataHora,
        'imageFile':this._imageFile
      };

  Conta.map(dynamic obj){

    this._valor = obj['valor'];
    this._dataHora = obj['dataHora'];
    this._imageFile = obj['imageFile'];
    this._id = obj['id'];
  }

  double get valor => _valor;
  String get dataHora => _dataHora;
  String get imageFile => _imageFile;
  int get id => _id;

  /*Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();
    mapa["valor"] = _valor;
    mapa["dataHora"] = _dataHora;
    mapa["imageFile"] = _imageFile;

    if(id != null){mapa["id"] = _id;}

    return mapa;
  }*/

  Map toMap() {
    Map<String, dynamic> map = {
      "valor" : this._valor,
      "dataHora" : this._dataHora,
      "imageFile" : this._imageFile,
    };

    if (id != null) {
      map["id"] = _id;
    }
    return map;
  }


  Conta.fromMap(Map mapa){

    this._valor = mapa['valor'];
    this._dataHora = mapa['dataHora'];
    this._imageFile = mapa['imageFile'];
    this._id = mapa['id'];
  }

  Conta.fromMap2(Map<String, dynamic> mapa){

    this._valor = mapa['valor'];
    this._dataHora = mapa['dataHora'];
    this._imageFile = mapa['imageFile'];
    this._id = mapa['id'];
  }

}