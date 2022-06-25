import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/data_categoria.dart';
import '../data/data_produto.dart';
import 'package:pediu_chegou/screens/produto_screen.dart';
import 'package:pediu_chegou/util/backgroud.dart';


class ListaProduto extends StatefulWidget {
  final DataCategoria categoria;
  ListaProduto(this.categoria);

  @override
  _ListaProdutoState createState() => _ListaProdutoState(categoria);
}

class _ListaProdutoState extends State<ListaProduto> {
  final DataCategoria categoria;
  _ListaProdutoState(this.categoria);

   String id_categoria;
  //importando a class modelo do fire base
  List<DataProduto> items;

  //variavel de instancia do firebase
  var db = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot> produItens;

  @override
  void initState() {
    super.initState();
    id_categoria = categoria.id;
    // ignore: deprecated_member_use
    items = List();
    produItens?.cancel();

    CollectionReference reference = db.collection('produtos');//db.collection('produtos')'categoria_id'
    Query query = reference.where('categoria_id', isEqualTo: id_categoria);
   // print("ID da categoria ${id_categoria}");
   // print("ID da query ${query}");
    produItens = query.snapshots().listen((snapshot) {
      final List<DataProduto> modelo = snapshot.docs
          .map((documents) =>
          DataProduto.fromMap(documents.data(), documents.id))
          .toList();

      setState(() {
        this.items = modelo;
       // print('estado da conexao ${items}');
      });
    });
    

  }

  @override
  void dispose() {
    produItens?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Backgroud(),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(categoria.nome,
                    style: const TextStyle(
                        fontFamily: "Lobster",
                        fontSize: 27,
                        fontWeight: FontWeight.w300,
                        color: Colors.white
                    ),
                  ),
                  centerTitle: true,
                ),
              ),

              SliverToBoxAdapter(
                child: StreamBuilder<QuerySnapshot>(
                    stream: getData(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:

                         // print('estado da conexao ${snapshot.connectionState}');
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
                                //print('index do listview ${index}');
                                //print('valor do items ${items[index]}');
                                return  Container(
                                  height: 124,
                                  width: 300,
                                  margin: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      borderRadius: new BorderRadius.circular(8.0),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.black54,
                                          blurRadius: 5.0,
                                          offset: new Offset(2.0, 5.0),
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: ListTile(
                                      leading: Container(
                                        width: 90.0,
                                        height: 90.0,
                                        decoration: BoxDecoration(
                                          //color: Colors.red,
                                          image: DecorationImage(
                                              image: NetworkImage(items[index].url),
                                              fit: BoxFit.fitHeight),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(80.0)),
                                        ),
                                      ),
                                      title: Text(items[index].nome.toLowerCase(),
                                        style: const TextStyle(fontWeight: FontWeight.bold,
                                            fontSize: 20
                                        ),
                                      ),
                                      subtitle:Container(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 5,),
                                            Text(items[index].descricao,
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            SizedBox(height: 10,),
                                            Text("R\$ ${items[index].valor}",
                                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.green,),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => ProdutoScreen(items[index]))
                                        );
                                      },
                                    ),
                                  ),
                                );
                              });
                      }
                    },
                  ),
              )
            ],
          )
        ],
      ),
    );
  }
  //metodo que retorna os dados da colecao
  Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance.collection("produtos").snapshots();
  }
}
