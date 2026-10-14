// 02_indice_nao_e_identidade.dart
// Demonstra: a armadilha nº1 na ESCOLHA do valor -- usar o indice da lista como
//   ValueKey(index). Parece que "tem key", mas o indice NAO e' estavel: quando
//   voce remove um item do meio, os de baixo mudam de indice, a key muda junto
//   e o estado (a cor) descasa. E' o pior tipo de bug: silencioso, nao crasha.
// Vire a constante usarId para ver os dois lados: false = ValueKey(indice), o
//   bug; true = ValueKey(item.id), o valor estavel que conserta.

import 'dart:math';

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaLista()));

// * false: usa o INDICE como key (bug silencioso ao remover).
//   true: usa o ID estavel (a cor acompanha o item certo).
const bool usarId = false;

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
  // A cor e' sorteada uma vez, no initState -> e' o "estado" que deve seguir
  // o item. Se ela troca ao remover outro item, a key nao esta identificando.
  late final Color _cor;

  @override
  void initState() {
    super.initState();
    _cor = Color(0xFF000000 | Random().nextInt(0x00FFFFFF));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      color: _cor,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
    Item(id: 1, label: 'Item 1'),
    Item(id: 2, label: 'Item 2'),
    Item(id: 3, label: 'Item 3'),
    Item(id: 4, label: 'Item 4'),
  ];

  void _removerPrimeiro() {
    setState(() {
      _itens = _itens.sublist(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(usarId ? 'ValueKey(id) - certo' : 'ValueKey(indice) - bug'),
      ),
      body: Column(
        children: [
          for (var i = 0; i < _itens.length; i++)
            ColorfulTile(
              // ! Com usarId=false, a key e' o INDICE i. Ao remover o topo, o que
              //   era indice 1 vira 0, 2 vira 1... a key de cada tile muda e o
              //   Flutter casa por posicao de novo: as cores "sobem" e descasam.
              // * Com usarId=true, a key e' o item.id (estavel): a cor acompanha
              //   o item mesmo depois de remover.
              key: usarId ? ValueKey(_itens[i].id) : ValueKey(i),
              label: _itens[i].label,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _itens.isEmpty ? null : _removerPrimeiro,
        icon: const Icon(Icons.delete),
        label: const Text('Remover o 1º'),
      ),
    );
  }
}
