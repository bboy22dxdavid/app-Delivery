import 'package:flutter/material.dart';
import 'package:pediu_chegou/abas/aba_categoria.dart';
import 'package:pediu_chegou/abas/aba_inicial.dart';
import 'package:pediu_chegou/abas/aba_lojas.dart';
import 'package:pediu_chegou/abas/aba_pedidos.dart';
import 'package:pediu_chegou/abas/aba_suporte.dart';
import 'package:pediu_chegou/widgets/botao_carrinho.dart';
import 'package:pediu_chegou/widgets/custon_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageContoller =  PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageContoller,
      physics:  NeverScrollableScrollPhysics(),
      children:  [
        Scaffold(
          body: AbaInicial(),
          drawer: CustonDrawer(_pageContoller),
          floatingActionButton:  BotaoCarrinho(),
        ),
        Scaffold(
          drawer: CustonDrawer(_pageContoller),
          body: AbaCategorias(),
          floatingActionButton:   BotaoCarrinho(),

        ),
        Scaffold(
          drawer: CustonDrawer(_pageContoller),
          body: AbaPedidos(),
        ),

        Scaffold(
          drawer: CustonDrawer(_pageContoller),
          body: AbaLojas(),
        ),
        Scaffold(
          drawer: CustonDrawer(_pageContoller),
          body: AbaSuporte(),
        ),
      ],
    );
  }
}

