import 'package:flutter/material.dart';
import 'package:pediu_chegou/tiles/categoria_tile.dart';
import 'package:pediu_chegou/util/app_colors.dart';

class AbaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      //FUNCAO QUE RETORNA O BACKGROUD COM DEGRADER
      Widget _buildBodyBack() => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.gradienteI,
                AppColors.gradienteII,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
      );
    return Stack(
     children: [
       _buildBodyBack(),
        CustomScrollView(
         slivers: [
          const SliverAppBar(
             floating: true,
             snap: true,
             backgroundColor: Colors.transparent,
             elevation: 0.0,
             flexibleSpace: FlexibleSpaceBar(
               title: Text("Categoria",
                 style: TextStyle(
                   fontFamily: "Lobster",
                   fontSize: 27,
                   fontWeight: FontWeight.w300
                 ),
               ),
               centerTitle: true,
             ),
           ),
           SliverToBoxAdapter(
             child: Container(
               color: Colors.transparent,
               height: 350,
               child: Center(
                   child: CategoriaTile()
               ),
             ),
           ),
         ],
       )

     ],
    );
  }
}
