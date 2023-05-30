import 'package:flutter/material.dart';
import 'PaginaPrincipal.dart';

void main() {
  runApp(const Mijuego());
}

class Mijuego extends StatelessWidget{
  const Mijuego({Key? key }):super(key: key);


  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginaPrincipal(),

    );
  }
  
}