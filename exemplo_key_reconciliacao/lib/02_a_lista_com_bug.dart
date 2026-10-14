// 02_a_lista_com_bug.dart
// Demonstra: o BUG ao vivo. Uma lista de tiles stateful do mesmo tipo e um botao
//   que inverte a ordem. Ao clicar, os ROTULOS trocam, mas as CORES ficam
//   paradas na posicao. O estado grudou na cadeira, nao na pessoa.
// Novo em relacao ao 01: a lista agora reordena (setState com reversed) e
//   NAO ha key nos tiles -- e' isso que expoe o problema da reconciliacao.

import 'dart:math';

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaLista()));

// Um item de dados simples: id ESTAVEL + rotulo. O id vai virar a key no 03.
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
      appBar: AppBar(title: const Text('A lista com bug (sem key)')),
      body: Column(
        children: [
          for (final item in _itens)
            // ! SEM key. Ao inverter, o Flutter casa os Elements por POSICAO +
            //   runtimeType (canUpdate: mesmo tipo, key null dos dois lados).
            //   Resultado: reaproveita o Element (com a cor) na mesma posicao.
            //   Os rotulos trocam, as cores ficam paradas.
            ColorfulTile(label: item.label),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _inverter,
        child: const Icon(Icons.swap_vert),
      ),
    );
  }
}
