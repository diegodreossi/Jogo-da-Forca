import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jogo_da_forca/main.dart';

import 'jogodaforca.dart';
import 'palavras.dart';
import 'resultado.dart';

class TelaAdivinhar extends StatefulWidget {
  final String palavra;
  final String forcaatual;
  const TelaAdivinhar(
      {Key? key, required this.palavra, required this.forcaatual})
      : super(key: key);

  @override
  _TelaAdivinharState createState() => _TelaAdivinharState(palavra, forcaatual);
}

class _TelaAdivinharState extends State<TelaAdivinhar> {
  final String palavra;
  final String forcaatual;
  TextEditingController chute = TextEditingController();

  _TelaAdivinharState(this.palavra, this.forcaatual);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent[100],
      floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.yellowAccent[400],
          child: Icon(Icons.help_outline),
          onPressed: () {
            Instrucoes(context);
          }),
      body: ListView(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Qual é a palavra?',
                    style: TextStyle(color: Colors.black, fontSize: 50),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    forcaatual,
                    style: TextStyle(color: Colors.black, fontSize: 100),
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Card(
                  borderOnForeground: true,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 40,
                      width: 250,
                      decoration: BoxDecoration(color: Colors.white),
                      child: TextField(
                        controller: chute,
                        onSubmitted: (value) {
                          //---
                          chute.value = TextEditingValue(
                            text: chute.text,
                            selection: TextSelection.collapsed(
                                offset: chute.text.length),
                          );
                          //---
                          VerificarChute(context, chute.text, palavra);
                        },
                        decoration: InputDecoration(
                          labelText: 'Tentativa',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      VerificarChute(context, chute.text, palavra);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[600])),
                  ),
                ),
              ]),
              Row(
                children: [
                  Container(
                    height: 150,
                    width: 250,
                    //decoration: BoxDecoration(color: Colors.green),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage(
                                              title: 'Jogo da Forca!',
                                            )));
                              },
                              child: new Text(
                                '  Sair',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}

Instrucoes(BuildContext context) {
  // configura o button
  Widget okButton = ElevatedButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Instruções"),
    content: Text("Apenas as primeiras letras de cada palavra são maiusculas"),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

VerificarChute(BuildContext context, String adv, String palavra) {
  if (adv == palavra) {
    //chute.text
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TelaResultado(palavra: palavra, vitorioso: true)));
  } else {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TelaResultado(palavra: palavra, vitorioso: false)));
  }
}
