import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:jogo_da_forca/adivinharpalavra.dart';
import 'package:jogo_da_forca/jogodaforca.dart';
import 'package:jogo_da_forca/palavras.dart';
import 'package:jogo_da_forca/resultado.dart';

void main() {
  runApp(MyApp());
}

//Parece que só falta fazer a área de chutar a palavra

class MyApp extends StatelessWidget /*with PortraitModeMixin*/ {
  final PalavraForca ex = new PalavraForca('Exemplo', 'Exemplo');
  //const MyApp();
  @override
  Widget build(BuildContext context) {
    //Essa função define a orientação de tela do app
    SystemChrome.setPreferredOrientations([
        //Esses travam em modo paisagem
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        //Esses em modo retrato.
        //DeviceOrientation.portraitUp,
        //DeviceOrientation.portraitDown,
      ]);
    
    String aparecertelama = ''; //Aparecer tela my app
    String pa = 'Exemplo';
    for (int x = 0; x < pa.length; x++) {
      if (pa[x] == ' ') {
        aparecertelama = aparecertelama + ' ';
      } else {
        aparecertelama = aparecertelama + '_';
      }
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jogo da Forca',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Jogo da Forca!'),
        '/resultado': (context) => TelaResultado(palavra: '', vitorioso: false),
        '/jogodaforca': (context) => JogoForca(
              ppalavra: ex,
              ch: 5,
              tela: aparecertelama,
            ),
        '/adivinharpalavra':(context)=>  TelaAdivinhar(palavra: 'Exemplo', forcaatual: 'Exempl_'),  
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.yellowAccent[100],
      //appBar: AppBar(
      //  title: Text(widget.title),
      //),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Icon(
                  Icons.book,
                  size: 100,
                ),
              ),
              Text(widget.title,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Diverta-se ao tentar adivinhar a palavra secreta!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    IrJogo(context);
                  },
                  child: Text('Jogar Agora!'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

void IrJogo(BuildContext context) {
  DefinirPalavras();
  Random ramdom = new Random();
  int np = ramdom.nextInt(listapalavras.length);
  int chancesp;

  String aparecertela = '';

  if (listapalavras[np].palavra.length <= 4) {
    chancesp = 3;
  } else {
    chancesp = 5;
  }

  for (int x = 0; x < listapalavras[np].palavra.length; x++) {
    if (listapalavras[np].palavra[x] == ' ') {
      aparecertela = aparecertela + ' ';
    } else {
      aparecertela = aparecertela + '_'; //+ ' ';
    }
  }

  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => JogoForca(
                ppalavra: listapalavras[np],
                ch: chancesp,
                tela: aparecertela,
              )));
}
