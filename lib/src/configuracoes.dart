import 'package:flutter/material.dart';
import 'package:sorteador/src/resultado.dart';

class Config extends StatefulWidget {
  var valoresBase = [];
  int menorValor;
  int maiorValor;
  Config(this.valoresBase, this.menorValor, this.maiorValor, {super.key});
  @override
  ConfigState createState() => ConfigState();
}

class ConfigState extends State<Config> {
  var _espacoDoSorteio = [];
  int valorMinimo = 0;
  int valorMaximo = 0;
  int quantidade = 0;
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
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(top: 32, bottom: 52),
                child: Text(
                  "Escolha abaixo quantos números deseja sortear",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black45,
                  ),
                )),
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 32),
              child: Slider(
                  value: _alterador,
                  min: 1,
                  max: _espacoDoSorteio.length.toDouble(),
                  label: _alterador.toString(),
                  divisions: _espacoDoSorteio.length - 1,
                  onChanged: (double novoValor) {
                    setState(() {
                      _alterador = novoValor;
                    });
                  }),
            ),
            ElevatedButton(
                // color: Colors.blue,
                // padding: EdgeInsets.fromLTRB(32, 10, 32, 10),
                child: const Text(
                  "Confirmar",
                  style: TextStyle(fontSize: 22, color: Colors.white),
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
