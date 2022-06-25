import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/data_categoria.dart';
import 'package:pediu_chegou/screens/lista_produto.dart';

class CategoriaGrade extends StatefulWidget {

  @override
  _CategoriaGradeState createState() => _CategoriaGradeState();
}

class _CategoriaGradeState extends State<CategoriaGrade> {
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
          DataCategoria.fromMap(documents.data(), documents.id)).toList();

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
              return GridView.builder(
                padding: const EdgeInsets.all(4.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 0.8
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index){
                   
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ListaProduto(items[index]))
                        );
                      },
                      child: Card(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AspectRatio(
                                aspectRatio: 1.0,
                              child: Image.network(
                                  items[index].url,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(items[index].nome,
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );
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
