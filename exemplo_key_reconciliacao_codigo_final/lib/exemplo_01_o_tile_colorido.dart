// exemplo_01_o_tile_colorido.dart
// Demonstra: a peca do bug -- um tile STATEFUL que sorteia a cor no initState e
//   a guarda no proprio State. A cor mora no Element, nao vem por parametro.
// Ponto de partida da aula: aqui nada quebra ainda. Duas cores fixas na tela.
//   A tensao aparece no 02, quando a lista comeca a reordenar.

import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaTiles()));

// * O tile guarda a cor NO STATE, sorteada uma vez no initState.
//   E' essa escolha que, la no 02, deixa o bug visivel: se a cor viesse por
//   parametro no construtor, ela viajaria junto com o widget e nao haveria bug.
class ColorfulTile extends StatefulWidget {
  const ColorfulTile({super.key, required this.label});

  final String label;

  @override
  State<ColorfulTile> createState() => _ColorfulTileState();
}

class _ColorfulTileState extends State<ColorfulTile> {
  late final Color _cor;

  @override
  void initState() {
    super.initState();
    // initState roda UMA vez, quando o Element e' criado. A cor nasce aqui e
    // fica guardada no State -- ela e' o "estado grudento" da aula.
    _cor = Color(0xFF000000 | Random().nextInt(0x00FFFFFF));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: _cor,
      alignment: Alignment.center,
      child: Text(
        widget.label,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class TelaTiles extends StatelessWidget {
  const TelaTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O tile colorido')),
      body: const Column(
        children: [
          ColorfulTile(label: 'Tile A'),
          ColorfulTile(label: 'Tile B'),
        ],
      ),
    );
  }
}
