import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/data_categoria.dart';
import 'package:pediu_chegou/screens/lista_produto.dart';

class CategoriaTile extends StatefulWidget {
  @override
  State<CategoriaTile> createState() => _CategoriaTileState();
}

class _CategoriaTileState extends State<CategoriaTile> {
//importando a class modelo do fire base
  List<DataCategoria> items;

  //variavel de instancia do firebase
  var db = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot> cetegItens;

  @override
  void initState() {
    super.initState();

    // ignore: deprecated_member_use
    items = List();
    cetegItens?.cancel();

    cetegItens = db.collection('categorias').snapshots().listen((snapshot) {
      final List<DataCategoria> modelo = snapshot.docs
          .map((documents) =>
              DataCategoria.fromMap(documents.data(), documents.id))
          .toList();

      setState(() {
        this.items = modelo;
        //print('estado da conexao ${items}');
      });
    });
  }

  @override
  void dispose() {
    cetegItens?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<QuerySnapshot>(
        stream: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:

              //  print('estado da conexao ${snapshot.connectionState}');
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );

            default:
              //List<DocumentSnapshot> documentos = snapshot.data.docs;
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                   // print('index do listview ${index}');
                   // print('valor do items ${items[index].nome}');
                    return  ListTile(
                        leading:  CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(items[index].url)
                        ),
                        title: Text(
                          items == null
                              ? "Verifique sua conexão com a inernet"
                              : items[index].nome,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white,),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ListaProduto(items[index]))
                          );
                        },
                      );
                  });
          }
        },
      ),
    );
  }

  //metodo que retorna os dados da colecao
  Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance.collection("categorias").snapshots();
  }
}
