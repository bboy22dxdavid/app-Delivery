import 'package:cloud_firestore/cloud_firestore.dart';
import 'data_produto.dart';

class DataCarinho {
  String cid;
  String categoria;
  String pid;
  int qtd;
  String url;

  DataProduto modeloProduto;


  //construtor vazio da casse
  DataCarinho();

  DataCarinho.fromMap(DocumentSnapshot snapshot){
   cid = snapshot.id;
   categoria = snapshot["categorias"];
   pid = snapshot["pid"];
   qtd = snapshot["qtd"];
  }

  Map<String, dynamic> toMap(){
    return {
      "categorias": categoria,
      "pid": pid,
      "qtd": qtd,
      "produto": modeloProduto.toResumedMap(),
    };
  }
}