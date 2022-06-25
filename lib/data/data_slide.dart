
class DataSlide{
  String _id ;
  String _informativo;
  String _url_imagem1 ;
  String _url_imagem2;

  String _key;


   DataSlide(this._id, this._informativo, this._url_imagem1, this._url_imagem2, this._key);

  DataSlide.map(dynamic obj){
    this._id = obj['id'];
    this._informativo = obj['informativo'];
    this._url_imagem1 = obj['url_imagem1'];
    this._url_imagem2 = obj['url_imagem2'];
    this._key = obj['key'];
  }


   String get id => _id;
   String get informativo => _informativo;
   String get url_imagem1 => _url_imagem1;
   String get url_imagem2 => _url_imagem2;
  String get key => _key;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['informativo'] = _informativo;
    map['url_imagem1'] = _url_imagem1;
    map['url_imagem2'] = _url_imagem2;
    map['key'] = _key;

    return map;
  }

   DataSlide.fromMap(Map<String, dynamic> map, String id){
    this._id = id ?? '';
    this._informativo = map['informativo'];
    this._url_imagem1 = map['url_imagem1'];
    this._url_imagem2 = map['url_imagem2'];
    this._key = map['key'];
  }

}