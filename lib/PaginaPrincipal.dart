import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pajaro.dart';
import 'package:flutter_application_1/barrera.dart';



class PaginaPrincipal extends StatefulWidget{
  

  @override
  _PaginaPrincipalState createState()=> _PaginaPrincipalState(); 
  
  }

  class _PaginaPrincipalState extends State<PaginaPrincipal>{

    static double pajaroY= 0;
    double posisioninicial= pajaroY;
    double height=0;
    double time=0;
    double gravedad= -6.9;
    double velocidad= 3.5;
    double anchopajaro=0.1;
    double largopajaro=0.1;

    //configuracion del juego 
    bool juegohacommenzado= false;

    //variables barreras
    static List<double> barreraX=[2, 2 + 1.5];
    static double anchobarrera=0.5;
    List<List<double>> largobarrera=[
      [0.6 , 0.4],
      [0.4 , 0.6],
    ];

    void Comenzarjuego(){
      juegohacommenzado = true;
      Timer.periodic(const Duration(milliseconds: 10), (timer) { 

        height= gravedad * time * time + velocidad * time;

        setState(() {
          pajaroY= posisioninicial- height;
        });
        print(pajaroY);

        //verificar si se murio
        if(Estamuerto()){
          timer.cancel();
          _muestreDialogo();

        }
         
        //mover mapa 
        movermapa();

        //se mantiene
        time += 0.01;

        

      });
    }


    void movermapa(){
      for (var i = 0; i < barreraX.length; i++) {
        setState(() {
          barreraX[i]-=0.005;
        });

        if (barreraX[i]<-1.5) {
          barreraX[i]+=3;
        }
      }
    }

    void reiniciarJuego(){
      Navigator.pop(context);
      setState(() {
        pajaroY=0;
        juegohacommenzado=false;
        time=0;
        posisioninicial=pajaroY;
      });

    }

    void _muestreDialogo() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            title: const Center(
              child: Text(
                "TERMINO EL JUEGO",
                style: TextStyle(color: Colors.white),
                ),
            ),  
            actions: [
              GestureDetector(
                onTap: reiniciarJuego,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    color: Colors.white,
                    child: const Text(
                      'JUGAR DE NUEVO',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ), 
                )
              )
            ]   
          );
        }
      );
    }

    void jump(){
      setState(() {
        time=0;
        posisioninicial=pajaroY;  
      });
    }
    
    bool Estamuerto(){
      //verificar si se choco con la parte de arriba 
      if (pajaroY < - 1|| pajaroY > 1 ){
          return true;
        }

      //revisar cuando choca con una barrera
      for (var i = 0; i < barreraX.length; i++) {
        if (barreraX[i]<= anchopajaro && 
            barreraX[i]+ anchobarrera >= - anchopajaro && 
            (pajaroY<= -1 + largobarrera[i][0]||
              pajaroY + largopajaro>= 1 - largobarrera[i][1])) {
          return true;
        }
        
      }
      
      return false;
    }



    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: juegohacommenzado ? jump : Comenzarjuego,
        child: Scaffold(
          body: Column (
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: const Color.fromARGB(255, 119, 189, 247),
                  child: Center(
                    child: Stack(
                      children: [
                        MiPajaro(
                          pajaroY: pajaroY,
                          anchopajaro: anchopajaro,
                          largopajaro: largopajaro,
                        ),

                        Container(
                          child: Text(
                            juegohacommenzado ? '' : 'T A P PARA JUGAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                        ),
                        
                        MiBarrera(
                          barreraX: barreraX[0],
                          anchobarrera: anchobarrera,
                          largobarrera: largobarrera[0][0],
                          isThisBottomBarrier: false,
                        ),

                        MiBarrera(
                          barreraX: barreraX[0],
                          anchobarrera: anchobarrera,
                          largobarrera: largobarrera[0][1],
                          isThisBottomBarrier: true,
                        ),

                        MiBarrera(
                          barreraX: barreraX[1],
                          anchobarrera: anchobarrera,
                          largobarrera: largobarrera[1][0],
                          isThisBottomBarrier: false,
                        ),

                        MiBarrera(
                          barreraX: barreraX[1],
                          anchobarrera: anchobarrera,
                          largobarrera: largobarrera[1][1],
                          isThisBottomBarrier: true,
                        ),

                      ], 
                    ),
                  )
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          child: Text(
                             'Juego Realizado por Johan Duarte ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40
                            ),
                          ),
                        ),
                      ]
                    )
                  )
                ),
                
              ),
            ]
          ),
        ),
      );
    }
  }

  