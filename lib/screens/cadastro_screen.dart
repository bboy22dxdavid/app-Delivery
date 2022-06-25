import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pediu_chegou/modelo/modelo_usuario.dart';
import 'package:pediu_chegou/util/backgroud.dart';
import 'package:scoped_model/scoped_model.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  //chave do formulario
  final _formKey = GlobalKey<FormState>();
  //chave do scaffold
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //controladores
  final _nomeControler = TextEditingController();
  final _emailControler = TextEditingController();
  final _senhaControler = TextEditingController();
  final _enderecoControler = TextEditingController();
  final _telefoneControler = TextEditingController();

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
                  title: Text('Cadastro',
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
                    if (model.isLoading) {
                      return  const Padding(
                        padding:  EdgeInsets.only(top: 150.0),
                        child: Center(child: CircularProgressIndicator(),),
                      );
                    }
                    return Form(
                      key: _formKey,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 20, left: 40, right: 40),
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
                            controller: _nomeControler,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  //fontFamily: "Lobster",
                                  fontSize: 15.0),
                              filled: true,
                              fillColor: Colors.white24,
                              hintText: "Nome",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                                  borderSide: BorderSide(
                                      color: Colors.white24, width: 0.5)),
                              prefixIcon:  Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            // ignore: missing_return
                            validator: (text) {
                              if (text.isEmpty)
                                return "Nome inválido!";
                            },
                          ),
                          const SizedBox(
                            height: 10.0,
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
                            controller: _telefoneControler,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  //fontFamily: "Lobster",
                                  fontSize: 15.0),
                              filled: true,
                              fillColor: Colors.white24,
                              hintText: "(61)999999999",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                                  borderSide: BorderSide(
                                      color: Colors.white24, width: 0.5)),
                              prefixIcon:  Icon(
                                Icons.phone_android,
                                color: Colors.white,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            // ignore: missing_return
                            validator: (text) {
                              if (text.isEmpty)
                                return "Nome inválido!";
                            },
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: _enderecoControler,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  //fontFamily: "Lobster",
                                  fontSize: 15.0),
                              filled: true,
                              fillColor: Colors.white24,
                              hintText: "Endereço",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                                  borderSide: BorderSide(
                                      color: Colors.white24, width: 0.5)),
                              prefixIcon:  Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                            ),
                            // ignore: missing_return
                            validator: (text) {
                              if (text.isEmpty)
                                return "Endereço inválido!";
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
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: FloatingActionButton(
                              backgroundColor: Colors.white24,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                              child: const Text(
                                "Criar Conta",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              onPressed: (){
                                if(_formKey.currentState.validate()){
                                  //criando o mapa para salvar os dados
                                  Map<String, dynamic> userData = {
                                    "nome": _nomeControler.text,
                                    "email": _emailControler.text,
                                    "endereco": _enderecoControler.text,
                                    "telefone": _telefoneControler.text,
                                  };
                                  model.signUp(
                                      userData: userData,
                                      pass: _senhaControler.text,
                                      onSuccess: _onSuccess,
                                      onFail: _onFail
                                  );
                                  //print("verificando a funcao de salvar ${model.signUp}");
                                }
                              },
                            ),
                          ),
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
    //funcao para colocar a snapbar de sucesso
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(
        const SnackBar(content: Text("Conta criada com Sucesso!",
          style:  TextStyle(
              fontFamily: "Lobster",
              fontSize: 27,
              fontWeight: FontWeight.w300,
              color: Colors.white
          ),
        ),

          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        )
    );
    Future.delayed(Duration(seconds: 2)).then((value){
      Navigator.of(context).pop();
    });
  }

  //FUNCAO QUE INDICA FALHA
  void _onFail(){

    //funcao para colocar a snapbar de sucesso
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(
        const SnackBar(content: Text("Falha ao Criar Conta",
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


}
