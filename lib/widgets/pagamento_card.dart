import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pediu_chegou/modelo/modelo_carinho.dart';

class PagametoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Forma de Pagamento",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]
          ),
        ),
        leading: Icon(Icons.credit_card_sharp),
        trailing: Icon(Icons.keyboard_arrow_down_sharp),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite a Forma de pagamento"
              ),
              initialValue: ModeloCarinho.of(context).Formapagamento ?? "",
              onFieldSubmitted: (text){
                FirebaseFirestore.instance.collection("pagamento").doc(text)
                    .get().then((docSnap){
                  //condicao para verificar se o cupom existe ou nao
                  if(docSnap.data() != null){
                    //aplicando o desconto
                    ModeloCarinho.of(context).setPagamento(text, docSnap.data()['forma']);
                    //caso existe o cupom no banco de dados
                    // ignore: deprecated_member_use
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Forma de pagamento ${docSnap.data()['forma']}!",
                          textAlign: TextAlign.center,
                        ),
                          backgroundColor: Colors.green,
                        )
                    );
                  }else{
                    ModeloCarinho.of(context).setPagamento(null, "");
                    //caso não existe o cupom no banco de dados
                    // ignore: deprecated_member_use
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Escolha uma forma de Pagamento!",
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
