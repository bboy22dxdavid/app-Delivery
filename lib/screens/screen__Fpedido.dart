import 'package:flutter/material.dart';
import 'package:pediu_chegou/util/app_colors.dart';
import 'package:pediu_chegou/util/backgroud.dart';

class FProdutoScreen extends StatelessWidget {
  //variavel que ira receber o id
  final String idPedido;
  //construtor da class
  FProdutoScreen(this.idPedido);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Backgroud(),
          CustomScrollView(
            slivers: [
              const SliverAppBar(
                floating: true,
                snap: true,
                //elevation: 0.0,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Pedido Realizado",
                    style:  TextStyle(
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
                child: Container(
                  padding:const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const SizedBox(height: 100.0,),
                      const Icon(Icons.check,
                        color: AppColors.botao,
                        size: 80.0,
                      ),
                      const Text("Pedido realizado com Sucesso!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0,
                            color: Colors.white
                        ),
                      ),
                      Text("Codigo do Pedido: $idPedido",
                        style:const  TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                      SizedBox(height: 30,),

                      // ignore: deprecated_member_use
                      FlatButton(
                        child: const Text(
                          "Clique aqui para Retorna a tela Inicial",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                               color: Colors.white70, fontSize: 20.0),
                           ),
                            onPressed: (){
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                             }
                          ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }


}
