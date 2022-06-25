import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LojaTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  LojaTile(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200.0,
            child: Image.network(
              snapshot["img"],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot["titulo"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0
                  ),
                ),
                Text(
                  snapshot["endereco"],
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: (){
                    // ignore: deprecated_member_use
                    launch("https://www.google.com/maps/search/?api=1&query=${snapshot["lat"]},"
                        "${snapshot["long"]}");
                  },
                  child: const Text(
                    "Ver no Mapa",
                    textAlign: TextAlign.start,
                  ),
                textColor: Colors.blueAccent,
                padding: EdgeInsets.zero,
              ),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: (){
                  // ignore: deprecated_member_use
                  launch("tel:${snapshot["telefone"]}");
                },
                child: const Text(
                  "Ligar",
                  textAlign: TextAlign.start,

                ),
                textColor: Colors.blueAccent,
                padding: EdgeInsets.zero,
              ),
            ],
          )
        ],
      ),
    );

  }
}
