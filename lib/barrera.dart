import 'package:flutter/material.dart';

class MiBarrera extends StatelessWidget{
   // ignore: prefer_typing_uninitialized_variables
   final anchobarrera; 
   // ignore: prefer_typing_uninitialized_variables
   final largobarrera; 
   // ignore: prefer_typing_uninitialized_variables
   final barreraX;
   final bool isThisBottomBarrier;

  MiBarrera(
      {this.largobarrera,
      this.anchobarrera,
      required this.isThisBottomBarrier,
      this.barreraX});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment( (2 * barreraX + anchobarrera) / (2 - anchobarrera),
          isThisBottomBarrier ? 1 : -1),
      child: Container(
        color: Colors.red,
        width: MediaQuery.of(context).size.width * anchobarrera / 2,
        height: MediaQuery.of(context).size. height * 3 / 4 * largobarrera / 2
       ), 
     ); 
  }
}