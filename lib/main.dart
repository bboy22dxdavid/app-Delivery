import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pediu_chegou/modelo/modelo_carinho.dart';
import 'package:pediu_chegou/modelo/modelo_usuario.dart';
import 'package:pediu_chegou/screens/inicio_screen.dart';
import 'package:scoped_model/scoped_model.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ModeloUsuario>(
        model: ModeloUsuario(),
        child: ScopedModelDescendant<ModeloUsuario>(
          builder: (context, child, model){
            return ScopedModel<ModeloCarinho>(
              model: ModeloCarinho(model),
              child: MaterialApp(
                title: 'App Delivery',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                ),
                home: InicioScreen(),
              ),
            );
          },
        )
    );
  }
}