import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

class Resultado extends StatefulWidget {
  var valoresBase = [];
  int valorMinimo;
  int valorMaximo;
  int quantidadeParaSortear;
  Resultado(this.valoresBase, this.valorMinimo, this.valorMaximo,
      this.quantidadeParaSortear,
      {super.key});
  @override
  ResultadoState createState() => ResultadoState();
}

class ResultadoState extends State<Resultado> {
  var valoresSorteados = [];
  String sorteados = "";
  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  List shuffle(List items) {
    var random = Random();

    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  String _sortearVarios(List lista) {
    int contador = 1;
    String valores;
    valores = lista[0].toString();
    while (contador <= (widget.quantidadeParaSortear - 1)) {
      setState(() {
        valores = '$valores , ${lista[contador].toString()}';
      });
      contador++;
    }
    return valores;
  }

  void _quantidadeSorteada() {
    var numero = 0;
    //verificação de quantos números serão sorteados
    if (widget.quantidadeParaSortear == 1) {
      numero = Random().nextInt(widget.valoresBase.length);
      //sendo somente um, é apresentado a posição sorteada
      setState(() {
        sorteados = widget.valoresBase[numero].toString();
      });
    } else {
      if (widget.quantidadeParaSortear > 1 &&
          widget.quantidadeParaSortear <= widget.valoresBase.length) {
        setState(() {
          sorteados = _sortearVarios(shuffle(widget.valoresBase));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _quantidadeSorteada();
    _portraitModeOnly();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Números sorteados"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              sorteados,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 70,
              ),
            )
          ],
        ),
      ),
    );
  }
}
