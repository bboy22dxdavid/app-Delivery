import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pediu_chegou/modelo/modelo_carinho.dart';

class DecontoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Cupom de Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700]
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: [
          Padding(
              padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu Cupom"
              ),
              initialValue: ModeloCarinho.of(context).cupomCode ?? "",
              onFieldSubmitted: (text){
                FirebaseFirestore.instance.collection("cupoms").doc(text)
                    .get().then((docSnap){
                      //condicao para verificar se o cupom existe ou nao
                  if(docSnap.data() != null){
                    //aplicando o desconto
                    ModeloCarinho.of(context).setCupon(text, docSnap.data()['porcentagem']);
                    //caso existe o cupom no banco de dados
                    // ignore: deprecated_member_use
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Desconto de ${docSnap.data()['porcentagem']}% aplicado!",
                          textAlign: TextAlign.center,
                        ),
                          backgroundColor: Colors.green,
                        )
                    );
                  }else{
                    ModeloCarinho.of(context).setCupon(null, 0);
                    //caso não existe o cupom no banco de dados
                    // ignore: deprecated_member_use
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Cupom Não Existe!",
                          textAlign: TextAlign.center,
                        ),
                          backgroundColor: Colors.red,
                        )
                    );
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
