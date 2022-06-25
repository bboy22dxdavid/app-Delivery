import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';


class ModeloUsuario extends Model {
  //variavel que instancia a autenticacao do firebase
  FirebaseAuth _auth = FirebaseAuth.instance;

  //variavel que instancia a Usuario do firebase
 User firebaseUser;
  //User firebaseUser;
  //variavel que verifica se esta carregando.
  bool isLoading = false;



  //criando um mapa vasizio com dados do usuario
  Map<String, dynamic> userData = Map();

  //instanciando a classe
  static ModeloUsuario of(BuildContext context) =>
      ScopedModel.of<ModeloUsuario>(context);


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrenUser();

}

  //METODO DE ENTRAR.
  void signIn({@required String email,@required  String senha,
    @required VoidCallback onSuccess,@required VoidCallback onFail}) async{
    //indicando que esta carregando
    isLoading = true;
    //notificando as telas
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: senha).then((user)async{
      //salvando o usuario no banco
      firebaseUser = user.user;
      //print("teste da funcao signup ${firebaseUser.user.email}");
       await _loadCurrenUser();
      // await teste();
      //salvando os dados
      onSuccess();
      //indicando que esta carregando
      isLoading = false;
      //notificando as telas
      notifyListeners();
    }).catchError((erro){
      //informando que deu erro ao salvar os dados
      onFail();
      //indicando que esta carregando
      isLoading = false;
      //notificando as telas
      notifyListeners();
      //print("mensagem de erro ${erro}");
    });
  }

  //METODO CADASTRAR.
  void signUp({@required Map<String,dynamic> userData,@required String pass,
    @required VoidCallback onSuccess,@required VoidCallback onFail,}){
    //indicando que esta carregando
    isLoading = true;
    //notificando as telas
    notifyListeners();
    //criando o usuario no banco
    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass
    ).then((users){
    //se deu certo salvar no banco
      firebaseUser = users.user;
     // print("teste da funcao signup ${firebaseUser}");

      //salvando os dados manualmente no banco
      _savdeUserData(userData);
      //salvando os dados
      onSuccess();
      //indicando que esta carregando
      isLoading = false;
      //notificando as telas
      notifyListeners();
      //print("teste da userData ${userData}");

    }).catchError((erro){
    //informando que deu erro ao salvar os dados
      onFail();
      //indicando que esta carregando
      isLoading = false;
      //notificando as telas
      notifyListeners();
     // print("mensagem de erro ${erro}");
    });
  }

  //METODO RECUPERAR SENHA.
  void recoverPass(String email){
    //recuperando a senha com email
    _auth.sendPasswordResetEmail(email: email);
    //print("testando funcao de recuperacao de senha");
  }

  //METODO VERIFICA SE ESTA LOGADO.
  bool isLoggedIn(){
    return firebaseUser != null;
  }

  //funcao que cria o novo usuario no banco de dados
  Future<Null> _savdeUserData(Map<String, dynamic> userData) async{
    this.userData = userData;
    await FirebaseFirestore.instance.collection("usuarios").doc(firebaseUser.uid).set(userData);
  }

  //funcao que desloga
  void signOut() async {
    //aguardando deslogar
    await _auth.signOut();
    //resetando os dados do usuario
    userData = Map();
    //indicando para o banco que nao a usuario logado
    firebaseUser = null;
    //notificando as telas
    notifyListeners();
  }

//funcao para pegar o usuario logado
  Future<Null> _loadCurrenUser() async{
    //condição para verificar se o usuario e nullo
    if(firebaseUser == null)
      //pegando o usuario atual
      firebaseUser = await _auth.currentUser;
    //print(" pegando o usuario atual ${_auth.currentUser}");

    //verificar se o e difernte de nulo e pq ele logou
    if(firebaseUser != null){
      //pegando os dados do usuario
      if(userData["nome"] == null){
        DocumentSnapshot docUser = await FirebaseFirestore.instance.collection("usuarios").
        doc(firebaseUser.uid).get();
        //pegando os dados da colecao
        userData = docUser.data();
        firebaseUser = await _auth.currentUser;
        //print("pegando os dados da colecao ${_auth.currentUser.email}");
        //notificando as telas
        notifyListeners();
      }
    }
  }
}