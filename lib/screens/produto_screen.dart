import 'package:flutter/material.dart';
import 'package:pediu_chegou/data/data_carinho.dart';
import 'package:pediu_chegou/modelo/modelo_carinho.dart';
import '../data/data_produto.dart';
import 'package:pediu_chegou/modelo/modelo_usuario.dart';
import 'package:pediu_chegou/screens/carrinho_screen.dart';
import 'package:pediu_chegou/screens/login_screen.dart';
import 'package:pediu_chegou/util/app_colors.dart';
import 'package:pediu_chegou/util/backgroud.dart';

class ProdutoScreen extends StatefulWidget {
  final DataProduto produto;
  ProdutoScreen(this.produto);

  @override
  _ProdutoScreenState createState() => _ProdutoScreenState(produto);
}

class _ProdutoScreenState extends State<ProdutoScreen> {

  final DataProduto produto;
  String size = "0";
  _ProdutoScreenState(this.produto);

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
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(produto.nome,
                    style: const TextStyle(
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
                child: ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                              //print('index do listview ${index}');
                              //print('valor do items ${items[index]}');
                              children: [
                                AspectRatio(
                                    aspectRatio: 0.9,
                                  child: Image(
                                      image: NetworkImage(produto.url),
                                      fit: BoxFit.fill
                                    ),
                                  ),
                                Padding(
                                    padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(produto.nome,
                                        style:const TextStyle(
                                            color: Colors.white,
                                          fontSize: 20
                                        ),
                                        maxLines: 3,
                                      ),
                                      Text("R\$ ${produto.valor}",
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 22,
                                          fontWeight: FontWeight.bold
                                        ),
                                        maxLines: 3,
                                      ),
                                      SizedBox(height: 10.0,),
                                      Text("Descrição: ${produto.descricao}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400
                                        ),
                                        maxLines: 3,
                                      ),
                                      SizedBox(height: 16.0,),
                                      SizedBox(
                                        height: 44.0,
                                        // ignore: deprecated_member_use
                                        child: RaisedButton(
                                          onPressed: (){
                                            //verificando se o usuario esta logado
                                            if(ModeloUsuario.of(context).isLoggedIn()){
                                              //adicionar  ao carrinho

                                              //criando o novo datacarrinho do produto
                                              DataCarinho carrinho = DataCarinho();
                                              carrinho.qtd = 1;
                                              carrinho.pid = produto.id;
                                              carrinho.categoria = produto.nome;
                                              carrinho.modeloProduto = produto;
                                              //recebendo a instancia do modelo carinho
                                              ModeloCarinho.of(context).addCardItem(carrinho);
                                              //ir para tela de login
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context)=> CarrinhoScreen())
                                              );

                                            }else{
                                              //ir para tela de login
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context)=> LoginScreen())
                                              );
                                            }

                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16.0),
                                          ),
                                          child: Text(
                                            ModeloUsuario.of(context).isLoggedIn() ?
                                            "Adicionar ao Carrinho" :
                                            "Entre para Comprar",
                                            style:const  TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              fontFamily: "Lobster",
                                            ),
                                          ),
                                          color: AppColors.botao,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
