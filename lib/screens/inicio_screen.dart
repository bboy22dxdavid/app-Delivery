import 'package:flutter/material.dart';
import 'package:pediu_chegou/componentes/image_animada.dart';
import 'package:pediu_chegou/util/backgroud.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home_screen.dart';

class InicioScreen extends StatefulWidget {

  @override
  _InicioScreenState createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.transparent,
     body: Stack(
       children: [
           SplashScreen(
             seconds: 5,
             //rota para a pagina home
             navigateAfterSeconds: HomeScreen(),
             loaderColor: Colors.transparent,
             backgroundColor: Colors.transparent,
           ),

         Backgroud(),
         ImageAnimada(),
         CustomScrollView(
           slivers: [
            SliverToBoxAdapter(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 500, left: 50),
                    child: Text(
                      "Seja Bem-Vindo ao nosso app",
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: -1.2,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 77),
                    child: Text(
                      "Pizzaria X",
                      style: TextStyle(
                          fontSize: 30,
                          letterSpacing: -2.2,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
           ],
         ),
       ],
     ),
    );
  }
}
