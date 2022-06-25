import 'package:flutter/material.dart';
import 'package:pediu_chegou/modelo/modelo_usuario.dart';
import 'package:pediu_chegou/screens/login_screen.dart';
import 'package:pediu_chegou/tiles/drawer_tile.dart';
import 'package:pediu_chegou/util/app_colors.dart';
import 'package:pediu_chegou/util/backgroud.dart';
import 'package:scoped_model/scoped_model.dart';

class CustonDrawer extends StatelessWidget {
  final PageController pageController;


  CustonDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Backgroud(),
          ListView(
            padding: EdgeInsets.only(left: 35.0, top: 16.0),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0,16.0,8.0),
                height: 210.0,
                child:  Stack(
                  children: [
                    const Positioned(
                        top: 8.0,
                        left: 60.0,
                        child: Image(
                              image: AssetImage("assets/logomenor.png"), fit: BoxFit.cover
                        )
                    ),
                    const Positioned(
                      top: 89.0,
                        left: 0.0,
                        child: Text(
                          "PEDIU CHEGOU",
                          style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        )
                    ),
                    Positioned(
                      left: 0.0,
                        bottom: 0.0,
                        child: ScopedModelDescendant<ModeloUsuario>(
                          builder: (context, child, model){
                            // verifica se o usuario esta logado
                            //print("O usuario e: ${model.isLoggedIn()}");
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text("Olá, ${!model.isLoggedIn() ? "" : model.userData["nome"]}",
                                  style: const TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 18.0, color: Colors.white
                                  ),
                                ),
                                GestureDetector(
                                  child: Text(!model.isLoggedIn() ?
                                    "Entre ou Cadastre-se >"
                                    : "Sair",
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                        fontSize: 16.0, color: AppColors.tercenaria
                                    ),
                                  ),
                                  onTap: (){
                                    //iniciando condicao para deslogar
                                    if(!model.isLoggedIn()){
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => LoginScreen())
                                      );
                                    } else{
                                      model.signOut();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        )
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Inicio", pageController, 0),
              DrawerTile(Icons.list_alt, "Produtos", pageController, 1),
              DrawerTile(Icons.playlist_add_check_outlined, "Pedidos", pageController, 2),
              DrawerTile(Icons.location_on_outlined, "Loja", pageController, 3),
              DrawerTile(Icons.settings, "Suporte", pageController, 4),
            ],
          )
        ],
      ),
    );
  }
}
