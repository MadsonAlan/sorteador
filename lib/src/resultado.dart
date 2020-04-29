import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

class Resultado extends StatefulWidget {
  var valoresBase = [];
  int valorMinimo;
  int valorMaximo;
  int quantidadeParaSortear;
  Resultado(this.valoresBase, this.valorMinimo, this.valorMaximo,
      this.quantidadeParaSortear);
  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  var valoresSorteados = [];
  String sorteados = "";
  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  List shuffle(List items) {
    var random = new Random();

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
    while (contador <= (widget.quantidadeParaSortear-1)) {
      setState(() {
        valores = valores + ", " + lista[contador].toString();
      });
      print("estou em sortear vários");
      contador++;
    }
    return valores;
  }

  void _quantidadeSorteada() {
    print("entrei na quantidade sorteada");
    var numero;
    //verificação de quantos números serão sorteados
    if (widget.quantidadeParaSortear == 1) {
      print("entrei no if");
      numero = Random().nextInt(widget.valoresBase.length);
      //sendo somente um, é apresentado a posição sorteada
      setState(() {
        sorteados = widget.valoresBase[numero].toString();
      });
    } else {
      print("entrei no else");
      if (widget.quantidadeParaSortear > 1 &&
          widget.quantidadeParaSortear <= widget.valoresBase.length) {
        print("entrei no segundo if");

        print(shuffle(widget.valoresBase));
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
        title: Text("Números sorteados"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              sorteados,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 70,
              ),
            )
          ],
        ),
      ),
    );
  }
}
