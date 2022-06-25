import 'dart:async';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/data_slide.dart';
import 'package:pediu_chegou/util/app_colors.dart';

class CardCarousel extends StatefulWidget {

  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  //importando a class modelo do fire base
  List<DataSlide> items;
  FirebaseFirestore firestore;


  //variavel de instancia do firebase
  var db = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot> homeitens;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    // ignore: deprecated_member_use
    items = List();
    homeitens?.cancel();

    homeitens = db.collection('app').snapshots().listen((snapshot) {
      final List<DataSlide> modelo = snapshot.docs.map(
              (documents) => DataSlide.fromMap(documents.data(), documents.id))
          .toList();

      setState(() {
        this.items = modelo;
        //print('estado da conexao ${items}');
      });
    });
  }

  @override
  void dispose() {
    homeitens?.cancel();
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
                    //print('index do listview ${index}');
                    //print('valor do items ${items[index]}');
                    return Card(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Center(
                                  child: Text(
                                    items == null
                                        ? "Verifique sua conexão com a inernet"
                                        : items[index].informativo,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              AspectRatio(
                                aspectRatio: 1.6,
                                child: Carousel(
                                  images: [
                                    items[index].url_imagem1,
                                    items[index].url_imagem2,
                                  ].map((url) {
                                    //print('valor do url no maps ${url}');
                                    return (url == null)
                                        ? Container(
                                            child: const Text(
                                              "Verifique sua conexão com a inernet",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          )
                                        : NetworkImage(url);
                                  }).toList(),
                                  dotSize: 3.0,
                                  dotSpacing: 15.0,
                                  dotBgColor: Colors.transparent,
                                  dotColor: AppColors.primary,
                                  autoplay: true,
                                  autoplayDuration: const Duration(seconds: 5),
                                ),
                              ),

                            ],
                          ),
                        ));
                  });
          }
        },
      ),
    );
  }

  //metodo que retorna os dados da colecao
  Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance.collection("app").snapshots();
  }
}
