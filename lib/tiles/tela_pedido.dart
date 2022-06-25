import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaPedido extends StatelessWidget {
  final String pedidoId;

  TelaPedido(this.pedidoId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection("pedidos").doc(pedidoId)
              .snapshots(),
          // ignore: missing_return
          builder: (context, snapshot){
            //print("retorno vazio do banco de dados${snapshot.data.data()}");
            //iniciando condicao para verificar se contem dado
            if(!snapshot.hasData)
            return  Center(
            child: CircularProgressIndicator(),
            );
            else{
            int status = snapshot.data["status"];
            // print("retorno do banco de dados${snapshot.data.id}");
            return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("Código do Pedido ${snapshot.data.id}",
            style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0,),
            Text(
            _buildProdutoText(snapshot.data)
            ),
                 SizedBox(height: 4.0,),
                 Text("Status do Pedido",
                   style: TextStyle(fontWeight: FontWeight.bold),
                 ),
                 SizedBox(height: 4.0,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     _buildCircle("1", "Preparação", status, 1),
                     Container(
                       height: 1.0,
                       width: 40.0,
                       color: Colors.grey[500],
                     ),
                     _buildCircle("2", "Transpor", status, 2),
                     Container(
                       height: 1.0,
                       width: 40.0,
                       color: Colors.grey[500],
                     ),
                     _buildCircle("3", "Entrega", status, 3),
                   ],
                 )
               ],
             );
            }
          },
        ),
      ),
    );
  }

  String _buildProdutoText(DocumentSnapshot snapshot){
    String text = "Descrição:\n";
    for(LinkedHashMap p in snapshot["produtos"]){
      //print("dados do produto ${snapshot["total"]}");
      text += "Titulo: ${p["produto"]["nome"]} Qtd:${p["qtd"]}x "
          "Desconto ${snapshot["desconto"].toStringAsFixed(0)}\%  "
          "(R\$ ${snapshot["subpreco"].toStringAsFixed(2)})\n";
    }

    //iniciando a verificacao dos produtos
    text += "Total: R\$ ${snapshot["total"].toStringAsFixed(2)}";
    return text;
  }

  //funcao que retorna o status do pedido
  Widget _buildCircle(String titulo, String subTitulo, int status, int thisStatus){
    //iniciando os estatos
    Color backColor;
    Widget child;

    //primeira condicao, preparacao
    if(status < thisStatus){
      backColor = Colors.grey[500];
      child = Text(titulo, style: TextStyle(color: Colors.white),);
    }else if (status == thisStatus){
      //primeira condicao, transporte
      backColor = Colors.blueAccent;
      child = Stack(
        alignment: Alignment.center,
        children: [
          Text(titulo, style: TextStyle(color: Colors.white),),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    }else{
      //primeira condicao, entrege
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }
    return Column(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subTitulo)
      ],
    );
  }
}

