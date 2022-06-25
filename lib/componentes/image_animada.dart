import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ImageAnimada extends StatefulWidget {
  @override
  _ImageAnimadaState createState() => _ImageAnimadaState();
}

class _ImageAnimadaState extends State<ImageAnimada> {

  open(pagina){
    Navigator.push(context, MaterialPageRoute(builder: pagina));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120, bottom: 5),
              child: Center(
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: Lottie.asset("lottie/delivery.json"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
