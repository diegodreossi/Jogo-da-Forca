import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jogo_da_forca/main.dart';

import 'jogodaforca.dart';
import 'palavras.dart';

class TelaResultado extends StatefulWidget {
  final String palavra;
  final bool vitorioso;
  const TelaResultado(
      {Key? key, required this.palavra, required this.vitorioso})
      : super(key: key);

  @override
  _TelaResultadoState createState() => _TelaResultadoState(palavra, vitorioso);
}

Widget Vitoria(String pal) {
  return Text(
    'Voce acertou a palavra! Era $pal !',
    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  );
}

Widget Derrota(String pal) {
  return Text(
    'Voce errou a palavra! ! Era $pal !',
    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  );
}

// ignore: non_constant_identifier_names
Widget Resultado(String pal, bool vit) {
  if (vit == true) {
    return Vitoria(pal);
  } else {
    return Derrota(pal);
  }
}

class _TelaResultadoState extends State<TelaResultado> {
  final String palavra;
  final bool vitorioso;
  _TelaResultadoState(this.palavra, this.vitorioso);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellowAccent[100],
        body: Center(
          child: Container(
            height: 250,
            width: 600,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 5),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: 10,
                  ),
                  Center(
                    child: Resultado(palavra, vitorioso),
                  ),
                  Container(
                    height: 30,
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        IrJogo(context);
                      },
                      child: Text('Jogar Novamente!')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage(
                                      title: 'Jogo da Forca!',
                                    )));
                      },
                      child: Text('Sair')),
                ],
              ),
            ),
          ),
        ));
  }
}
