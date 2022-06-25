import 'package:flutter/material.dart';
import 'package:pediu_chegou/modelo/modelo_carinho.dart';
import 'package:pediu_chegou/util/app_colors.dart';
import 'package:scoped_model/scoped_model.dart';

class PrecoResumoCard extends StatelessWidget {
  //funcao para salvar o resumo
  final VoidCallback buy;
  //construtor
  PrecoResumoCard(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<ModeloCarinho>(
          builder: (context, child, modelo){
            //variaveis que recebem os dados do modelo
            double valor = modelo.getSubTotal();
            double disconto = modelo.getDisconto();
            String pagamento = modelo.getFormaPagamento();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Resumo do Pedido",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 12.0),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("SubTotal"),
                   Text("R\$ ${valor.toStringAsFixed(2)}"),
                 ],
               ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Desconto"),
                    Text("R\$ ${disconto.toStringAsFixed(2)}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Forma de Pagamento"),
                    Text("${pagamento}"),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: TextStyle(fontWeight: FontWeight.w500),),
                    Text("R\$ ${(valor - disconto).toStringAsFixed(2)}",
                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                // ignore: deprecated_member_use
                RaisedButton(
                  child: Text("Finalizar Pedido"),
                  textColor: Colors.white,
                  color: AppColors.botao,
                  onPressed: buy,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
