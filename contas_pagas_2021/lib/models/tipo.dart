
class Tipo {

  String _descricao_tipo;
  int _id;



  Tipo(this._id, this._descricao_tipo);

  Tipo.fromJson(Map<String, dynamic> json):
        this._id = int.tryParse(json['id']) ?? 0,
        this._descricao_tipo = json['descricao_tipo'];

  Map<String, dynamic> toJson() =>
      {
        '_descricao_tipo': this._descricao_tipo,
        };

  Tipo.map(dynamic obj){

    this._descricao_tipo = obj['descricao_tipo'];
    this._id = obj['id'];
  }

  String get descricao_tipo => _descricao_tipo;
  int get id => _id;



  Map toMap() {
    Map<String, dynamic> map = {
      "descricao_tipo" : this._descricao_tipo,
      };

    if (id != null) {
      map["id"] = _id;
    }
    return map;
  }


  Tipo.fromMap(Map mapa){

    this._descricao_tipo = mapa['descricao_tipo'];
    this._id = mapa['id'];
  }


  }


