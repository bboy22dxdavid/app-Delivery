import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pediu_chegou/data/data_carinho.dart';
import 'package:pediu_chegou/modelo/modelo_usuario.dart';
import 'package:scoped_model/scoped_model.dart';

class ModeloCarinho extends Model{
  //instanciando as classe
  ModeloUsuario user;

  //variavel que armazena o codigo do cupom de desconto
  String cupomCode;

  //variavel que armazena a forma de pagamento
  String Formapagamento = "dinheiro";
  String texte;

  //variavel que armazena a porcentagem de desconto
  int discontoPorcentagem = 0;

  //variaveis de controle
  List<DataCarinho> produtos =[];



  //construtor da classe
  ModeloCarinho(this.user){
    //condicao para mostra os itens somente se tiver logado
    if(user.isLoggedIn()){
      _loadCarrinhoItems();
    }
  }

  //variavel que indica que esta careegando
  bool isLoading = false;

  //instanciando o carinho
  static ModeloCarinho of(BuildContext context) =>
      ScopedModel.of<ModeloCarinho>(context);

  //funcao de add itens no carrinho
  void addCardItem(DataCarinho dataCarinho){
    //pegando os produtos e adicionando ao carinho
    produtos.add(dataCarinho);

    //adicionando os protudos no banco de dados
    FirebaseFirestore.instance.collection("usuarios").doc(user.firebaseUser.uid)
        .collection("carrinho").add(dataCarinho.toMap()).then((doc){
         dataCarinho.cid = user.firebaseUser.uid;
    });
    //notificando as telas
    notifyListeners();
  }

  //funcao de remover itens no carrinho
  void removeCardItem(DataCarinho dataCarinho){
    //deletando os protudos no banco de dados
    FirebaseFirestore.instance.collection("usuarios").doc(user.firebaseUser.uid)
        .collection("carrinho").doc(dataCarinho.cid).delete();
    //removendo item  do carrinho
    produtos.remove(dataCarinho);
    //notificando as telas
    notifyListeners();
  }

  //funcao de decrementar itens no carrinho
  void decProduto(DataCarinho dataCarinho){
    //decrementando a quantidade do produto
    dataCarinho.qtd--;
    //decrementando a quantidade do produto no banco
    FirebaseFirestore.instance.collection('usuarios').doc(user.firebaseUser.uid)
    .collection('carrinho').doc(dataCarinho.cid).update(dataCarinho.toMap());

    //notificando as telas
    notifyListeners();
  }


  //funcao de incrementar itens no carrinho
  void incProduto(DataCarinho dataCarinho){
    //incrementando a quantidade do produto
    dataCarinho.qtd++;
    //incrementando a quantidade do produto no banco
    FirebaseFirestore.instance.collection('usuarios').doc(user.firebaseUser.uid)
        .collection('carrinho').doc(dataCarinho.cid).update(dataCarinho.toMap());

    //notificando as telas
    notifyListeners();
  }

  //funcao que carrega os dados do banco para o carrinho
  void _loadCarrinhoItems() async{
    //obtendo dados do banco
   QuerySnapshot query = await  FirebaseFirestore.instance.collection('usuarios')
       .doc(user.firebaseUser.uid).collection('carrinho').get();
   //passando todos os dados da colecao do banco, para o produto
   produtos = query.docs.map((documento) => DataCarinho.fromMap(documento)).toList();

   //notificando as telas
   notifyListeners();
  }
//funcao que valida o cupom
  void setCupon(String cuponCode, int discPorcetagem){
    //salvando o codigo e a porcetangem de desconto
    this.cupomCode = cuponCode;
    this.discontoPorcentagem = discPorcetagem;

  }

  //funcao que salva a forma de pagamento
  void setPagamento(String text ,String forma){
    this.Formapagamento = forma;
    this.texte = text;
  }

  // funcao que retorna o subTotal
  double getSubTotal(){
    //iniciando o valor do subtotal
    double price = 0.0;

    //iniciando verificacao para navergar entre os produtos
    for(DataCarinho c in produtos){
      double valor = double.parse(c.modeloProduto.valor);
      //verifica se os produtos no carrinho sao nulos
      if(c.modeloProduto != null){
        //incrementar o preco
        price += c.qtd * valor;
        //print("Valor do produto${valor}");
      }
    }
    //retornando o preco
    return price;
  }

// funcao que retorna a forma de pagamento
  String getFormaPagamento(){
    //print("forma de pagamento ${Formapagamento}");
    //print("forma de pagamento ${discontoPorcentagem}");
    return Formapagamento;
  }

// funcao que retorna o desconto
  double getDisconto(){
    //retornara o subtotal * pelo desconto / por 100
    return getSubTotal() * discontoPorcentagem / 100;
  }

// funcao que atualiza os preco,
  void updatePrecos(){
    notifyListeners();
  }

// funcao que finaliza os pedidos
 Future<String> finalizarPedido() async{
    //verificar se a lista de produto e vazia
   if(produtos.length == 0) return null;
   //indica que esta carregando
   isLoading = true;

   //noificando as telas
   notifyListeners();

   //pegando os precos
   double subPreco = getSubTotal();
   double desconto = getDisconto();
   String pagamento = getFormaPagamento();
   final time = DateTime.now();


   //adicionando no banco de dados
   DocumentReference rePedido = await FirebaseFirestore.instance.collection("pedidos").add(
     {
       "idCliente": user.firebaseUser.uid,
       "produtos": produtos.map((DataCarinho) =>DataCarinho.toMap()).toList(),
       "cliente": user.userData["nome"],
       "endereco": user.userData["endereco"],
       "telefone": user.userData["telefone"],
       "data": time,
       "subpreco": subPreco,
       "desconto": desconto,
       "pagamento": pagamento,
       "total": subPreco - desconto,
       "status": 1
     }
   );

   await FirebaseFirestore.instance.collection("pedidos").doc(rePedido.id).update({

       "IDpedido": rePedido.id

   });

   //salvando o id do pedino na colecao do usuario
   await FirebaseFirestore.instance.collection("usuarios").doc(user.firebaseUser.uid)
   .collection("ordemPedido").doc(rePedido.id).set(
     {
       "ordenId": rePedido.id
     }
   );

   //pegando os pedidos da colecao
  QuerySnapshot query = await FirebaseFirestore.instance.collection("usuarios").doc(user.firebaseUser.uid)
       .collection("carrinho").get();


  //iniciando verificacao para deletar os pedidos
   for(DocumentSnapshot doc in query.docs){
     doc.reference.delete();
   }

   //limpando a lista local
   produtos.clear();
//retornando o desconto para 0
   discontoPorcentagem = 0;
//inativando o cupon
  cupomCode = null;

  //idicando que não esta mais carregando
   isLoading = false;
   //notificando as telas
   notifyListeners();

   return rePedido.id;
 }


}