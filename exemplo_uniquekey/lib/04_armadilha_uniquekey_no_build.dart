// 04_armadilha_uniquekey_no_build.dart
// Demonstra: a armadilha nº1 do modulo -- key: UniqueKey() dentro do build de
//   uma lista. Como uma UniqueKey nova nasce a cada frame, o Flutter conclui que
//   TODO item e' novo a cada rebuild e recria o State de todos. Resultado: as
//   cores (sorteadas no initState) reiniciam a cada clique, animacoes piscam, a
//   performance despenca. E' PIOR do que nao ter key nenhuma.
// Novo em relacao ao 02/03: la a troca da key era controlada (sob demanda); aqui
//   ela e' descontrolada (a cada build) -- por isso vira bug.
// Vire a constante modo para comparar com a key certa (ValueKey por id).

import 'dart:math';

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaLista()));

// * KeyModo.uniqueNoBuild: key: UniqueKey() no map -> recria tudo a cada frame.
//   KeyModo.valueId: key: ValueKey(id) -> identidade estavel, estado preservado.
enum KeyModo { uniqueNoBuild, valueId }

const KeyModo modo = .uniqueNoBuild;

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
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _cor,
        borderRadius: BorderRadius.circular(12),
      ),
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
  final List<Item> _itens = const [
    Item(id: 1, label: 'Item 1'),
    Item(id: 2, label: 'Item 2'),
    Item(id: 3, label: 'Item 3'),
    Item(id: 4, label: 'Item 4'),
  ];

  int _cliques = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          modo == KeyModo.valueId
              ? 'ValueKey(id) - certo'
              : 'UniqueKey no build - bug',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Cliques: $_cliques\n'
              'Clique em "Rebuild" e observe as cores. Bug = piscam/reiniciam; '
              'certo = ficam fixas.',
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (final item in _itens)
                  ColorfulTile(
                    // ! UniqueKey() aqui nasce NOVA a cada build -> o Flutter
                    //   descarta e recria o State de todos os itens a cada frame.
                    // * ValueKey(item.id) e' estavel -> o estado sobrevive.
                    key: modo == KeyModo.valueId
                        ? ValueKey(item.id)
                        : UniqueKey(),
                    label: item.label,
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => _cliques++),
        icon: const Icon(Icons.refresh),
        label: const Text('Rebuild (setState)'),
      ),
    );
  }
}
