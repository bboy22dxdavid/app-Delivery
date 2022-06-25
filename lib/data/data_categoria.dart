class DataCategoria{
  String _id ;
  String _nome;
  String _url ;

  DataCategoria(this._id, this._nome, this._url);

  DataCategoria.map(dynamic obj){
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._url = obj['url'];
  }

  String get url => _url;
  String get nome => _nome;
  String get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['nome'] = _nome;
    map['url'] = _url;

    return map;
  }

  DataCategoria.fromMap(Map<String, dynamic> map, String id){
    this._id = id ?? '';
    this._nome = map['nome'];
    this._url = map['url'];
  }
}