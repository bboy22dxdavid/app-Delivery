import 'package:flutter/material.dart';
import 'package:pediu_chegou/componentes/card_carousel.dart';
import 'package:pediu_chegou/tiles/categoria_grade.dart';
import 'package:pediu_chegou/util/backgroud.dart';

class AbaInicial extends StatefulWidget {
  @override
  _AbaInicialState createState() => _AbaInicialState();
}

class _AbaInicialState extends State<AbaInicial> {

  @override
  Widget build(BuildContext context) {
    return  Stack(
              children: [
                Backgroud(),
                CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      floating: true,
                      snap: true,
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text("App Delivery",
                          style: TextStyle(
                              fontFamily: "Lobster",
                              fontSize: 27,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        centerTitle: true,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.transparent,
                        height: 350,
                        child: Center(
                            child: CardCarousel()
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const Center(
                            child: Text("Cardapio",
                              style: TextStyle(
                                  fontFamily: "Lobster",
                                  fontSize: 27,
                                  fontWeight: FontWeight.w300,
                                color: Colors.white,
                                decoration: TextDecoration.none
                              ),
                            ),
                          ),
                          Container(
                            height: 360,
                            child: CategoriaGrade()
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
    );
  }
}
