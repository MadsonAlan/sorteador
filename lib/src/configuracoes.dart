import 'package:flutter/material.dart';
import 'package:sorteador/src/resultado.dart';

class Config extends StatefulWidget {
  var valoresBase = [];
  int menorValor;
  int maiorValor;
  Config(this.valoresBase, this.menorValor, this.maiorValor);
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  var _espacoDoSorteio = [];
  int valorMinimo;
  int valorMaximo;
  int quantidade;
  double _alterador = 1;
  void _setarInformacoes() {
    setState(() {
      _espacoDoSorteio = widget.valoresBase;
      valorMaximo = widget.maiorValor;
      valorMinimo = widget.menorValor;
    });
  }

  @override
  Widget build(BuildContext context) {
    _setarInformacoes();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 32, bottom: 52),
                child: Text(
                  "Escolha abaixo quantos números deseja sortear",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black45,
                  ),
                )),
            Padding(
              padding: EdgeInsetsDirectional.only(bottom: 32),
              child: Slider(
                value: _alterador,
                min: 1,
                max: _espacoDoSorteio.length.toDouble(),
                label: _alterador.toString(),
                divisions: _espacoDoSorteio.length-1,
                onChanged: (double novoValor) {
                  setState(() {
                    _alterador = novoValor;
                  });
                }),
              ),
            RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(32, 10, 32, 10),
                child: Text(
                  "Confirmar",
                  style: TextStyle(fontSize: 22),
                ),
                onPressed: () {
                  setState(() {
                    quantidade = _alterador.toInt();
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Resultado(_espacoDoSorteio,
                              valorMinimo, valorMaximo, quantidade)));
                }),
          ],
        ),
      ),
    );
  }
}
