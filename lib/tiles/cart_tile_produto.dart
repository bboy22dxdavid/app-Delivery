import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pediu_chegou/data/data_carinho.dart';
import 'package:pediu_chegou/modelo/modelo_carinho.dart';
import '../data/data_produto.dart';
import 'package:pediu_chegou/util/app_colors.dart';

class CartTileProduto extends StatelessWidget {
  final DataCarinho carinho;

  CartTileProduto(this.carinho);

  @override
  Widget build(BuildContext context) {

    Widget _buidContent(){

      ModeloCarinho.of(context).updatePrecos();
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 120.0,
            child: Image.network(
              carinho.modeloProduto.url,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      carinho.modeloProduto.nome,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "R\$ ${carinho.modeloProduto.valor}",
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16.0,
                          color: AppColors.botao
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            icon: Icon(Icons.remove),
                            color: Colors.red,
                            onPressed: carinho.qtd > 1 ? (){
                              ModeloCarinho.of(context).decProduto(carinho);
                            } : null
                        ),
                        Text(
                          carinho.qtd.toString(),
                        ),
                        IconButton(
                            icon: Icon(Icons.add),
                          color: Colors.green,
                            onPressed: (){
                              ModeloCarinho.of(context).incProduto(carinho);
                            }
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: (){
                            ModeloCarinho.of(context).removeCardItem(carinho);
                          },
                          child: Text(
                            "Remover",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 16.0,
                                color: Colors.grey[500]
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
          )
        ],
      );
    }

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        //se nao tiver os dados do produto
        child: carinho.modeloProduto == null ?
        //obtendo os dados do produto
        FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection("produtos").
          doc(carinho.pid).get(),
          builder:(context, snapshot){
            //print(" obtendo produto da coleção ${snapshot.hasData}");
            if(snapshot.hasData){
              //salvando os dados do protuto para recuperar depois
              carinho.modeloProduto = DataProduto.fromDocument(snapshot.data);
              //print("dados do carinho  ${carinho.pid}");
              //mostrando o conteudo
              return _buidContent();
            } else{
              //print("entrou no else  ${carinho.modeloProduto.id}");
              return Container(
                height: 70.0,
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              );
            }
          },
        ):
        //mostrando o conteudo
        _buidContent()
    );
  }
}


