import 'package:flutter/material.dart';
import 'package:pediu_chegou/modelo/modelo_usuario.dart';
import 'package:pediu_chegou/screens/cadastro_screen.dart';
import 'package:pediu_chegou/util/backgroud.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //chave do formulario
  final _formKey = GlobalKey<FormState>();
  //chave do scaffold
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //controladores
  final _senhaControler = TextEditingController();
  final _emailControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children:  [
          Backgroud(),
         CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              snap: true,
              //elevation: 0.0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Login',
                  style:  TextStyle(
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
                child: ScopedModelDescendant<ModeloUsuario>(
                  builder: (context, child, model){
                   if(model.isLoading)
                     return Padding(
                       padding: const EdgeInsets.only(top: 150.0),
                       child: Center(child: CircularProgressIndicator(),),
                     );
                   return Form(
                      key: _formKey,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 50, left: 40, right: 40),
                        children: [
                          SizedBox(
                            height:120,
                            child: Image.asset(
                              "assets/logomenor.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: _emailControler,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  //fontFamily: "Lobster",
                                  fontSize: 15.0),
                              filled: true,
                              fillColor: Colors.white24,
                              hintText: "E-mail",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                                  borderSide: BorderSide(
                                      color: Colors.white24, width: 0.5)),
                              prefixIcon:  Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            // ignore: missing_return
                            validator: (text) {
                              if (text.isEmpty || !text.contains("@"))
                                return "E-mail inválido!";
                            },
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: _senhaControler,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0),
                              filled: true,
                              fillColor: Colors.white24,
                              hintText: "Senha",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                  borderSide: BorderSide(
                                      color: Colors.white24, width: 0.5)),
                              prefixIcon:  Icon(
                                Icons.lock_outline,
                                color: Colors.white,
                              ),
                            ),
                            obscureText: true,
                            // ignore: missing_return
                            validator: (text) {
                              if (text.isEmpty || text.length < 6)
                                return "Senha inválida!";
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: (){
                                //print("clicou");
                                //verificando se e-mail esta vazio
                                if(_emailControler.text.isEmpty){
                                  _MensagemErro();
                                } else{
                                  model.recoverPass(_emailControler.text);
                                  _MensagemSucesso();
                                }
                              },
                              child: const Text(
                                "Esqueci minha senha",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13.0),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: FloatingActionButton(
                              backgroundColor: Colors.white24,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                              child:const Text(
                                "Entrar",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              onPressed: (){
                                //valida o formulario
                                if(_formKey.currentState.validate()){

                                }
                                model.signIn(
                                    email: _emailControler.text,
                                    senha: _senhaControler.text,
                                    onSuccess: _onSuccess,
                                    onFail: _onFail
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: 40,
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                  child: const Text(
                                    "Cadastre-se",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                  onPressed: (){
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) => CadastroScreen())
                                    );
                                  }
                              )
                          )
                        ],
                      ),
                    );
                  },
                )
            )
          ],
         )
        ],
      ),
    );
  }
  //FUNCAO QUE SALVA OS DADOS
  void _onSuccess (){
    Navigator.of(context).pop();
  }

  //FUNCAO QUE INDICA FALHA
  void _onFail(){
    //funcao para colocar a snapbar de sucesso
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(
        const SnackBar(content: Text("Falha ao Entrar na Conta",
          style:  TextStyle(
              fontFamily: "Lobster",
              fontSize: 27,
              fontWeight: FontWeight.w300,
              color: Colors.white
          ),
        ),

          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        )
    );
  }

  //FUNCAO QUE INDICA E-MAIL VAZIO
  void _MensagemErro(){
    //funcao para colocar a snapbar de sucesso
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(
        const SnackBar(content: Text("Insira um E-mail de recuperação!",
          style:  TextStyle(
              fontFamily: "Lobster",
              fontSize: 27,
              fontWeight: FontWeight.w300,
              color: Colors.white
          ),
        ),

          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        )
    );
  }

  //FUNCAO QUE O E-MAIL DE RECUPERAÇÃO FOI ENVIADO
  void _MensagemSucesso(){
    //funcao para colocar a snapbar de sucesso
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(
        const SnackBar(content: Text("E-mail de recuperação enviado com sucesso, Verifique seu E-mail",
          style:  TextStyle(
              fontFamily: "Lobster",
              fontSize: 27,
              fontWeight: FontWeight.w300,
              color: Colors.white
          ),
        ),

          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        )
    );
  }
}
