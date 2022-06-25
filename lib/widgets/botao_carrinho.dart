import 'package:flutter/material.dart';
import 'package:pediu_chegou/screens/carrinho_screen.dart';
import 'package:pediu_chegou/util/app_colors.dart';

class BotaoCarrinho extends StatefulWidget {
  @override
  _BotaoCarrinhoState createState() => _BotaoCarrinhoState();
}

class _BotaoCarrinhoState extends State<BotaoCarrinho> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> CarrinhoScreen())
          );
        },
      backgroundColor: AppColors.primary,
      child: Icon(Icons.add_shopping_cart_outlined, color: AppColors.carrinho,),
    );
  }
}
