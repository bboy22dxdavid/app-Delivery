// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pediu_chegou/util/backgroud.dart';
import 'package:url_launcher/url_launcher.dart';


class AbaSuporte extends StatelessWidget {
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
                  title: Text("Suporte",
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
                child: Card(
                  color: Colors.transparent,
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 300.0,
                        child: Image.asset(
                          "assets/icone.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding:  EdgeInsets.all(8.0),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                             Text(
                              "Caso esteja tendo problemas, Informe ao nosso suporte!",
                              textAlign: TextAlign.center,
                              style:  TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0, color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // ignore: duplicate_ignore
                        children: [

                          FlatButton(
                            onPressed: (){
                              launch("https://api.whatsapp.com/send?phone=5561995265600&text=Ol%C3%A1%2Ctudo%20bem%20%3F");
                            },
                            child: const Text(
                              "Whatsapp",
                              textAlign: TextAlign.start,

                            ),
                            textColor: Colors.blueAccent,
                            padding: EdgeInsets.zero,
                          ),
                          FlatButton(
                            onPressed: (){
                              launch("tel:61995013159");
                            },
                            child: const Text(
                              "Telefone",
                              textAlign: TextAlign.start,

                            ),
                            textColor: Colors.blueAccent,
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              )
            ]
        )
      ],
    );
  }
}
