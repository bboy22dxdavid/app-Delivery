import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pediu_chegou/modelo/modelo_usuario.dart';
import 'package:pediu_chegou/screens/login_screen.dart';
import 'package:pediu_chegou/tiles/tela_pedido.dart';
import 'package:pediu_chegou/util/app_colors.dart';
import 'package:pediu_chegou/util/backgroud.dart';

class AbaPedidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //verificando se esta logado
    if(ModeloUsuario.of(context).isLoggedIn()){
      //print("usuario logado");
      //obtendo o id do usuario
      String uid = ModeloUsuario.of(context).firebaseUser.uid;

      //recuperando todos os dados do usuario
      return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("usuarios").doc(uid)
        .collection("ordemPedido").get(),
        builder: (context, snapshot){
          //iniciando condicao para verificar se existe dados
          if(!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return Stack(
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
                        title: Text("Meus Pedidos",
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
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: snapshot.data.docs.map((doc) => TelaPedido(doc.id)).toList()
                          .reversed.toList(),
                        ),
                    )
                  ],
                )
              ],

            );
          }
        },
      );
    }else{
      //print("usuario não esta logado");
      return Container(
            padding: const EdgeInsets.only(top: 10.0, right: 16.0, left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Icon(Icons.list_outlined,
                  size: 80.0, color: AppColors.carrinho,
                ),
                const SizedBox(height: 16.0,),
                const Text("Faça o Login para acompanhar os Pedidos!",
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0,),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=> LoginScreen())
                    );
                  },
                  child:const Text("Entrar",
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  color: AppColors.botao,
                  textColor: Colors.white,
                )
              ],
            ),
          );
    }
  }
  //metodo que retorna os dados da colecao
  Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance.collection("app").snapshots();
  }
}
