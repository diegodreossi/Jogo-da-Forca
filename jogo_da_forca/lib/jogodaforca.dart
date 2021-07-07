import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jogo_da_forca/adivinharpalavra.dart';
import 'package:jogo_da_forca/resultado.dart';
import 'palavras.dart';

/*
Pro jogo da forca eu preciso da palavra original, do numero de chances, dos 
acertos, de uma variavel que mostre os riscos na tela para representar as letras
não descobertas

3/7 Estou tentando fazer aparecer os riscos da forca na tela

*/
class JogoForca extends StatefulWidget {
  final PalavraForca ppalavra;
  final int ch;
  final String tela;

  const JogoForca(
      {Key? key, required this.ppalavra, required this.ch, required this.tela})
      : super(key: key);

  @override
  _JogoForcaState createState() =>
      _JogoForcaState(ch, tela, pspalavra: ppalavra);
}

class _JogoForcaState extends State<JogoForca> {
  final PalavraForca pspalavra;
  final int chancesforca;
  final String tela;
  late String aparecertela = tela,
      aparecertela2 = '',
      l_erradas = '',
      l_erradas2 = '',
      aviso = '';
  late int chances = chancesforca;
  List<String> auxiliarforca = [];
  List<String> letras_erradas = [];
  List<String> letras_tentadas = [];
  int acertos = 0;
  var chute = TextEditingController();

  _JogoForcaState(
    this.chancesforca,
    this.tela, {
    required this.pspalavra,
  });

  //--------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    void Vitoria_Derrota(int chance, int acerto) {
      bool acertou;

      if (chance == 0 && acerto < pspalavra.palavra.length) {
        acertou = false;
      } else if (chance != 0 && acerto == pspalavra.palavra.length) {
        acertou = true;
      } else {
        acertou = false;
      }

      if (chance == 0 || acerto == pspalavra.palavra.length) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TelaResultado(
                    palavra: pspalavra.palavra, vitorioso: acertou)));
      }
    }

    void VerificarLetra(String letra) {
      bool repetida = false;
      bool lErradaRep = false;

      for (int x = 0; x < aparecertela.length; x++) {
        if (letra == aparecertela[x]) {
          repetida = true;
        }
      }

      for (int x = 0; x < letras_tentadas.length; x++) {
        if (letra == letras_tentadas[x]) {
          repetida = true;
        }
      }

      if (!repetida) {
        for (int x = 0; x < pspalavra.palavra.length; x++) {
          auxiliarforca.add(aparecertela[x]);
        }

        bool achouletra = false;
        for (int x = 0; x < pspalavra.palavra.length; x++) {
          if (letra == pspalavra.palavra[x]) {
            auxiliarforca[x] = letra;
            acertos++;
            achouletra = true;
          }

          if (letra.toLowerCase() == pspalavra.palavra[x]) {
            auxiliarforca[x] = letra.toLowerCase();
            acertos++;
            achouletra = true;
          }
        }

        if (!achouletra) {
          chances--;
          for (int x = 0; x < letras_erradas.length; x++) {
            if (letra == letras_erradas[x]) {
              lErradaRep = true;
            }
          }
          if (lErradaRep == false) {
            letras_erradas.add(letra);
          }
        }

        //Colocar a string atualizada a cada verificação de letra
        for (int x = 0; x < pspalavra.palavra.length; x++) {
          aparecertela2 = aparecertela2 + auxiliarforca[x];
        }
        aparecertela = aparecertela2;
        aparecertela2 = '';
        aviso = '';

        //Lista de letras erradas
        for (int w = 0; w < letras_erradas.length; w++) {
          l_erradas2 = l_erradas2 + letras_erradas[w] + ',';
        }
        l_erradas = l_erradas2;
        l_erradas2 = '';
      } else {
        chances--;
        aviso = 'AVISO: Letra Repetida, 1 chance perdida!';
      }
      letras_tentadas.add(letra);
      Vitoria_Derrota(chances, acertos);
    }

    Widget Teclas(String letr) {
      return SizedBox(
        width: 40,
        height: 30,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              VerificarLetra(letr);
            });
          },
          child: Text(letr),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green[600])),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.yellowAccent[100],
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          child: Text('Já sei'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TelaAdivinhar(
                        palavra: pspalavra.palavra, forcaatual: aparecertela)));
          },
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Dica: ${pspalavra.dica}',
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
                Row(
                  children: [
                    Text('Chances: $chances',
                        style: TextStyle(fontSize: 20, color: Colors.red)),
                  ],
                ),
                Row(
                  children: [
                    Text('Letras erradas: $l_erradas',
                        style: TextStyle(fontSize: 20, color: Colors.red)),
                  ],
                ),
                Row(
                  children: [
                    Text('$aviso',
                        style: TextStyle(fontSize: 20, color: Colors.red)),
                  ],
                ),
              ],
            ),
          ),
          //TextField(),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              aparecertela,
              style: TextStyle(fontSize: 100),
            ),
          ),
          Container(height: 10),
          //Row(children: [TextField(controller: chute,style: TextStyle(color: Colors.brown, fontSize: 10),)],),

          //Container(height: 30,width: 40,decoration: BoxDecoration(color: Colors.blue),
          //child: TextField(),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Teclas('A'),
              Teclas('B'),
              Teclas('C'),
              Teclas('D'),
              Teclas('E'),
              Teclas('F'),
              Teclas('G'),
              Teclas('H'),
              Teclas('I'),
              Teclas('J'),
              Teclas('K'),
              Teclas('L'),
              Teclas('M'),
              Teclas('N'),
              Teclas('O'),
              Teclas('P'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Teclas('Q'),
              Teclas('R'),
              Teclas('S'),
              Teclas('T'),
              Teclas('U'),
              Teclas('V'),
              Teclas('W'),
              Teclas('X'),
              Teclas('Y'),
              Teclas('Z'),
              Teclas('Ç'),
              Teclas('Ã'),
              Teclas('Õ'),
              Teclas('É'),
              Teclas('Í'),
              Teclas('Ó'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Container(
              //  width: 10,
              //),
              Teclas('Ê'),
              Teclas('Ú'),
              Teclas('Â'),
              Teclas('Î'),
              Teclas('Ô'),
              Teclas('Û'),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
          )
        ]));
  }
}
