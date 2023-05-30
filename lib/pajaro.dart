import 'package:flutter/material.dart';

class MiPajaro extends  StatelessWidget {
  final pajaroY;
  final double anchopajaro;
  final double largopajaro;

   MiPajaro({this.pajaroY, required this.anchopajaro, required this.largopajaro});
 
  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * pajaroY + largopajaro)/(2 - largopajaro)),
      child: Image.asset(
        'lib/imagenes/pajaro.png', 
        width: MediaQuery.of(context).size.height * anchopajaro / 2,
        height: MediaQuery.of(context).size.height * 3 /4 * largopajaro / 2,
        fit: BoxFit.fill,
      )
    );
  }
}