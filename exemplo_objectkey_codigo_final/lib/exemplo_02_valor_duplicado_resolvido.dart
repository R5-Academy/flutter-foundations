// exemplo_02_valor_duplicado_resolvido.dart
// Demonstra: o caso que a ValueKey NAO resolve -- itens sem id, com valores que
//   REPETEM (duas "Maria"). ValueKey(nome) coloca a mesma key em dois irmaos e
//   quebra; ObjectKey(pessoa) usa a instancia, entao duas "Maria" distintas sao
//   objetos distintos e cada tile mantem seu estado ao embaralhar.
// Novo em relacao ao 01: sai da tela de comparacoes e mostra o efeito real numa
//   lista stateful que reordena.
// Vire a constante modo para ver os dois lados.

import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaContatos()));

// * KeyModo.valueNome: usa ValueKey(p.nome) -> quebra com nomes repetidos.
//   KeyModo.objeto: usa ObjectKey(p) -> identifica pela instancia (correto).
enum KeyModo { valueNome, objeto }

const KeyModo modo = KeyModo.valueNome;

// Pessoa SEM id, so o nome -- e o nome pode repetir.
class Pessoa {
  Pessoa(this.nome);

  final String nome;
}

class ContatoTile extends StatefulWidget {
  const ContatoTile({super.key, required this.pessoa});

  final Pessoa pessoa;

  @override
  State<ContatoTile> createState() => _ContatoTileState();
}

class _ContatoTileState extends State<ContatoTile> {
  // A cor e' sorteada uma vez, no initState: e' o "estado" que deve seguir a
  // pessoa. Se ela troca ao embaralhar, a key nao esta identificando o item.
  late final Color _cor;

  @override
  void initState() {
    super.initState();
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
        widget.pessoa.nome,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class TelaContatos extends StatefulWidget {
  const TelaContatos({super.key});

  @override
  State<TelaContatos> createState() => _TelaContatosState();
}

class _TelaContatosState extends State<TelaContatos> {
  // Instancias estaveis: criadas uma vez, so embaralhadas depois. Repare nas
  // duas "Maria" e nos dois "Tony Stark" -- homonimos, instancias diferentes.
  final List<Pessoa> _pessoas = [
    Pessoa('Maria'),
    Pessoa('Tony Stark'),
    Pessoa('Bruce Wayne'),
    Pessoa('Tony Stark'),
    Pessoa('Maria'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          modo == KeyModo.objeto ? 'ObjectKey(p) - certo' : 'ValueKey(nome) - quebra',
        ),
      ),
      body: ListView(
        children: [
          for (final p in _pessoas)
            ContatoTile(
              // ! Com modo.valueNome, dois irmaos "Maria" viram a MESMA key ->
              //   "Multiple widgets used the same key". Nome nao e' identificador.
              // * Com modo.objeto, cada Pessoa e' uma instancia distinta ->
              //   ObjectKey separa as duas "Maria" e a cor segue a pessoa certa.
              key: modo == KeyModo.objeto ? ObjectKey(p) : ValueKey(p.nome),
              pessoa: p,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(_pessoas.shuffle),
        icon: const Icon(Icons.shuffle),
        label: const Text('Embaralhar'),
      ),
    );
  }
}
