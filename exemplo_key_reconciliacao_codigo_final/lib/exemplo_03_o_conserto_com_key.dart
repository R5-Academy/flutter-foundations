// exemplo_03_o_conserto_com_key.dart
// Demonstra: o CONSERTO. Uma unica linha muda em relacao ao 02 -- cada tile
//   ganha uma ValueKey com o id ESTAVEL do item. Agora, ao inverter, a cor
//   ACOMPANHA o rotulo: o Flutter passa a casar por identidade e MOVE o Element
//   (com o State/cor) para a nova posicao.
// Novo em relacao ao 02: key: ValueKey(item.id) no tile.

import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaLista()));

class Item {
  const Item({required this.id, required this.label});

  final int id;
  final String label;
}

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

class TelaLista extends StatefulWidget {
  const TelaLista({super.key});

  @override
  State<TelaLista> createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  List<Item> _itens = const [
    Item(id: 1, label: 'Tile A'),
    Item(id: 2, label: 'Tile B'),
  ];

  void _inverter() {
    setState(() {
      _itens = _itens.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O conserto (com ValueKey)')),
      body: Column(
        children: [
          for (final item in _itens)
            // * A key vai no TILE -- o widget que muda de posicao na lista.
            //   Com ela, canUpdate compara tambem a identidade: keys diferentes
            //   na posicao 0 dao false, entao o Flutter procura o Element pela
            //   key e o MOVE, levando o State (a cor) junto. A cor segue o item.
            ColorfulTile(key: ValueKey(item.id), label: item.label),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _inverter,
        child: const Icon(Icons.swap_vert),
      ),
    );
  }
}
