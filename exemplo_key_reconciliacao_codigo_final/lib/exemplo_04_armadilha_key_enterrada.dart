// exemplo_04_armadilha_key_enterrada.dart
// Demonstra: a regra de ouro -- ONDE a key vai. Ao embrulhar cada tile num
//   Padding, o filho direto que a lista reordena passa a ser o Padding. Se a key
//   fica no tile la dentro, o Padding continua SEM key e o pai reconcilia por
//   posicao de novo: o conserto do 03 QUEBRA.
// Novo em relacao ao 03: os tiles ganharam um Padding em volta. Troque a
//   constante usaLugarCerto para ver a key no lugar errado (bug) x no topo do
//   subtree (conserto).

import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaLista()));

// * Vire para false e a key vai parar no tile (errado): o bug volta.
//   Deixe true e a key sobe para o Padding (certo): a cor volta a acompanhar.
const bool usaLugarCerto = true;

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
      appBar: AppBar(title: const Text('Onde a key vai')),
      body: Column(
        children: [
          for (final item in _itens)
            if (usaLugarCerto)
              // * CERTO: a key vai no Padding -- o filho DIRETO que a lista
              //   reordena. E' ele que o pai reconcilia por posicao, entao e'
              //   nele que a key precisa estar. A cor acompanha o item.
              Padding(
                key: ValueKey(item.id),
                padding: const EdgeInsets.all(8),
                child: ColorfulTile(label: item.label),
              )
            else
              // ! ERRADO: a key esta ENTERRADA no tile. O filho direto e' o
              //   Padding, que continua sem key -> o pai reconcilia por posicao
              //   e o efeito da key se perde. O bug volta.
              Padding(
                padding: const EdgeInsets.all(8),
                child: ColorfulTile(key: ValueKey(item.id), label: item.label),
              ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _inverter,
        child: const Icon(Icons.swap_vert),
      ),
    );
  }
}
