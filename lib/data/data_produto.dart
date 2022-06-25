import 'package:cloud_firestore/cloud_firestore.dart';

class DataProduto{

  String _id;
  String _categoria_id;
  String _descricao;
  String _nome;
  bool _possui_adicional;
  String _url;
  String _valor;

  DataProduto(this._id, this._categoria_id, this._descricao, this._nome,
      this._possui_adicional, this._url, this._valor);

  DataProduto.map(dynamic obj){
    this._id = obj['id'];
    this._categoria_id = obj['categoria_id'];
    this._descricao = obj['descricao'];
    this._nome = obj['nome'];
    this._possui_adicional = obj['possui_adicional'];
    this._url = obj['url'];
    this._valor = obj['valor'];
  }

  String get valor => _valor;
  String get url => _url;
  bool get possui_adicional => _possui_adicional;
  String get nome => _nome;
  String get descricao => _descricao;
  String get categoria_id => _categoria_id;
  String get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['categoria_id'] = _categoria_id ;
    map['descricao'] = _descricao;
    map['nome'] = _nome;
    map['possui_adicional'] = _possui_adicional;
    map['url'] = _url;
    map['valor'] = _valor;

    return map;
  }

  DataProduto.fromMap(Map<String, dynamic> map, String id){
    this._id = id ?? '';
    this._categoria_id = map['categoria_id'];
    this._descricao = map['descricao'];
    this._nome = map['nome'];
    this._possui_adicional = map['possui_adicional'];
    this._url = map['url'];
    this._valor = map['valor'];
  }

  Map<String, dynamic> toResumedMap(){
    return{
    'nome': _nome,
    'descricao': _descricao,
    'possui_adicional': _possui_adicional,
    'valor':_valor
    };
  }

  DataProduto.fromDocument(DocumentSnapshot snapshot){
    this._id = snapshot.data().toString().contains('id') ? snapshot.get('id') : '';
    this._categoria_id  = snapshot['categoria_id'];
    this._descricao= snapshot['descricao'];
    this._nome  = snapshot['nome'];
    this._possui_adicional = snapshot['possui_adicional'];
    this._url = snapshot['url'];
    this._valor =snapshot['valor'];
  }
}