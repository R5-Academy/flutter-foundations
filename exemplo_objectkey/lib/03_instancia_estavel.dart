// 03_instancia_estavel.dart
// Demonstra: a armadilha nº1 da ObjectKey -- a instancia precisa ser ESTAVEL
//   entre rebuilds. ObjectKey identifica pela instancia (identical); se voce
//   recria os objetos dentro do build(), cada rebuild gera instancias novas,
//   identical() da sempre false e o Flutter descarta/recria o State de tudo --
//   o mesmo desastre do UniqueKey no build de lista, apesar de "ter ObjectKey".
// Novo em relacao ao 02: aqui um botao que so faz setState (nao muda a lista)
//   ja basta para expor o bug quando os objetos nascem no build.
// Vire a constante objetosEstaveis para ver os dois lados.

import 'dart:math';

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaEstabilidade()));

// * false: a lista de Pessoa e' recriada DENTRO do build -> ObjectKey inutil.
//   true: a lista vive no State, criada uma vez -> instancias estaveis (certo).
const bool objetosEstaveis = false;

class Pessoa {
  Pessoa(this.nome);

  final String nome;
}

class ColorTile extends StatefulWidget {
  const ColorTile({super.key, required this.nome});

  final String nome;

  @override
  State<ColorTile> createState() => _ColorTileState();
}

class _ColorTileState extends State<ColorTile> {
  late final Color _cor;

  @override
  void initState() {
    super.initState();
    // Sorteada uma vez. Se a cor muda a cada clique no botao, o State esta
    // sendo recriado -- sinal de que a ObjectKey perdeu a identidade.
    _cor = Color(0xFF000000 | Random().nextInt(0x00FFFFFF));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        widget.nome,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class TelaEstabilidade extends StatefulWidget {
  const TelaEstabilidade({super.key});

  @override
  State<TelaEstabilidade> createState() => _TelaEstabilidadeState();
}

class _TelaEstabilidadeState extends State<TelaEstabilidade> {
  // A lista ESTAVEL: criada uma unica vez, como campo do State.
  final List<Pessoa> _pessoasEstaveis = [
    Pessoa('Ana'),
    Pessoa('Bruno'),
    Pessoa('Carla'),
  ];

  int _cliques = 0;

  @override
  Widget build(BuildContext context) {
    // ! Quando objetosEstaveis=false, refazemos a lista AQUI dentro do build.
    //   Cada rebuild (cada clique no botao) cria Pessoas novas: identical()
    //   entre a antiga e a nova da false -> a cor reinicia a cada clique.
    final pessoas = objetosEstaveis
        ? _pessoasEstaveis
        : [Pessoa('Ana'), Pessoa('Bruno'), Pessoa('Carla')];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          objetosEstaveis
              ? 'Instancia estavel - certo'
              : 'Recriada no build - bug',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Cliques: $_cliques\n'
              'Clique no botao e observe as cores. Estaveis = cor fixa; '
              'recriadas no build = cor muda a cada clique.',
              style: const TextStyle(fontSize: 15),
            ),
          ),
          for (final p in pessoas)
            ColorTile(
              // A key e' a mesma em ambos os modos: ObjectKey(p). O que muda e'
              // se "p" e' a mesma instancia entre rebuilds (estavel) ou nova.
              key: ObjectKey(p),
              nome: p.nome,
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
