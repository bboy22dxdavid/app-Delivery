import 'package:flutter/material.dart';
import 'package:pediu_chegou/modelo/modelo_carinho.dart';
import 'package:pediu_chegou/modelo/modelo_usuario.dart';
import 'package:pediu_chegou/screens/login_screen.dart';
import 'package:pediu_chegou/screens/screen__Fpedido.dart';
import 'package:pediu_chegou/tiles/cart_tile_produto.dart';
import 'package:pediu_chegou/util/app_colors.dart';
import 'package:pediu_chegou/util/backgroud.dart';
import 'package:pediu_chegou/widgets/desconto_card.dart';
import 'package:pediu_chegou/widgets/pagamento_card.dart';
import 'package:pediu_chegou/widgets/preco_resumo_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CarrinhoScreen extends StatefulWidget {
  @override
  _CarrinhoScreenState createState() => _CarrinhoScreenState();
}

class _CarrinhoScreenState extends State<CarrinhoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Backgroud(),
           CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                //elevation: 0.0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text("Meu Carrinho",
                    style: TextStyle(
                        fontFamily: "Lobster",
                        fontSize: 27,
                        fontWeight: FontWeight.w300,
                        color: Colors.white
                    ),
                  ),
                  centerTitle: true,
                ),
                actions: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(right: 8.0),
                    child: ScopedModelDescendant<ModeloCarinho>(
                      builder: (context, child, model){
                        int itensProduto = model.produtos.length;
                        return Text(
                          "${itensProduto ?? 0} ${itensProduto == 1 ? "ITEM" : "ITENS"}",
                          style: TextStyle(fontSize: 17.0),
                        );
                      },
                    ),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: ScopedModelDescendant<ModeloCarinho>(
                    // ignore: missing_return
                    builder: (context, child, model){
                      /*iniciando condicao para verificar se o carrinho esta carregando
                      e usuario esta logado*/
                      if(model.isLoading && ModeloUsuario.of(context).isLoggedIn()){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                        /*iniciando condicao para verificar se o usuario esta logado*/
                      } else if(!ModeloUsuario.of(context).isLoggedIn()){
                        return Container(
                          padding: EdgeInsets.only(top: 200.0, right: 16.0, left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                             const Icon(Icons.remove_shopping_cart_outlined,
                                size: 80.0, color: AppColors.carrinho,
                              ),
                              const SizedBox(height: 16.0,),
                              const Text("Faça o Login para Adicionar os Produtos!",
                                style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold,
                                  color: Colors.white
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
                        /*iniciando condicao para verificar se o carrinho esta vazio*/
                      } else if(model.produtos == null || model.produtos.length == 0){
                        return  Center(
                          child:  Container(
                            padding: EdgeInsets.only(top: 200.0, right: 16.0, left: 16.0),
                            child:const Text("Nenhum produto no carrinho",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                        /*iniciando condicao para carregar a tela do carrinho*/
                      } else{
                        return ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: [
                            Column(
                              children: model.produtos.map((itens){
                                return CartTileProduto(itens);
                              }).toList(),
                            ),
                            DecontoCard(),
                            PagametoCard(),
                            PrecoResumoCard(() async{
                              //retorna o id
                             String ordeId = await model.finalizarPedido();
                             //condicao para verificar se e nullo
                              if(ordeId != null)
                                //print("ID do produto finalizado ${ordeId}");
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => FProdutoScreen(ordeId))
                                );
                            })
                          ],
                        );
                      }
                    }
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
