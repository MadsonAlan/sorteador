import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorteador/src/configuracoes.dart';
import 'package:sorteador/src/resultado.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerMinimo = TextEditingController();
  TextEditingController _controllerMaximo = TextEditingController();
  int valorMinimo;
  int valorMaximo;
  int quantidade;
  bool _configurar = false;
  var _espacoDoSorteio = [];
  String _validacao = "Normal";

  void _inserirValores() {
    print("atualizei as variaveis");
    setState(() {
      valorMinimo = int.tryParse(_controllerMinimo.text);
      valorMaximo = int.tryParse(_controllerMaximo.text);
      quantidade = 1;
    });
    _validador();
  }

  void _validador() {
    print("estou validando");
    if (valorMinimo < valorMaximo) {
      _calcularNumeros();
      setState(() {
        _validacao = "Normal";
      });
    } else {
      setState(() {
        _validacao =
            "O valor mínimo não pode ser o maior ou ambos serem iguais";
      });
    }
  }

  void _calcularNumeros() {
    print("estoucalculando o vetor");
    if (_espacoDoSorteio.isEmpty) {
      for (int i = valorMinimo; i <= valorMaximo; i++) {
        setState(() {
          _espacoDoSorteio.add(i);
        });
      }
      _chamarTela();
    } else {
      while (_espacoDoSorteio.isNotEmpty) {
        _espacoDoSorteio = [];
      }
      _calcularNumeros();
    }
  }

  void _chamarTela() {
    print("chamei a tela");
    if (_configurar == false) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Resultado(
                  _espacoDoSorteio, valorMinimo, valorMaximo, quantidade)));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Config(_espacoDoSorteio, valorMinimo, valorMaximo)));
    }
  }

  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    print("passei da orientação");
  }

  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[          
            Padding(
                padding: EdgeInsets.only(top: 32, left: 0, right: 0),
                child: Text(
                  "Escolha abaixo o interválo de números que serão usados para o sorteio",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black45,
                  ),
                )),
            TextField(
              keyboardType: TextInputType.number,
              controller: _controllerMinimo,
              decoration: InputDecoration(labelText: "Qual o menor número?"),
              maxLength: 3,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _controllerMaximo,
                decoration: InputDecoration(labelText: "E o número máximo?"),
                maxLength: 3,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 22),
              child: SwitchListTile(
                  title: Text(
                    "Desejo sortear mais de um número",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  ),
                  value: _configurar,
                  onChanged: (bool valor) {
                    setState(() {
                      _configurar = valor;
                    });
                  }),
            ),
            RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(32, 10, 32, 10),
                child: Text(
                  "Sortear",
                  style: TextStyle(fontSize: 22),
                ),
                onPressed: _inserirValores),
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Status: " + _validacao,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black38,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
