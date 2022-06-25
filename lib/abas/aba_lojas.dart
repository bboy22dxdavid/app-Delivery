import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pediu_chegou/tiles/loja_tile.dart';
import 'package:pediu_chegou/util/backgroud.dart';

class AbaLojas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Backgroud(),
        CustomScrollView(
            slivers:[
              const SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Nossas Lojas",
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
                child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection("lojas").get(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data.docs.map((documento) => LojaTile(documento)).toList(),

                      );
                    }
                  },
                ),
              )
            ]
        )
      ],
    );
  }
}
