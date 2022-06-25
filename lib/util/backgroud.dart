import 'package:flutter/material.dart';
import 'package:pediu_chegou/util/app_colors.dart';

class Backgroud extends StatefulWidget {
  @override
  _BackgroudState createState() => _BackgroudState();
}

class _BackgroudState extends State<Backgroud> {
  @override
  Widget build(BuildContext context) {
    return _buildBodyBack();
  }

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
}
