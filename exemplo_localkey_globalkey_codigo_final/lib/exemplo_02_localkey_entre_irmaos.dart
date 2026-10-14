// exemplo_02_localkey_entre_irmaos.dart
// Demonstra: o escopo da LocalKey -- ela só precisa ser única ENTRE IRMÃOS
//   (filhos do mesmo pai). Duas listas independentes podem reusar as MESMAS
//   ValueKeys sem nenhum conflito.
// Novo em relação ao 01: sai o desenho, entra o comportamento -- por que a
//   LocalKey basta para 99% dos casos.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DuasListas()));

class DuasListas extends StatelessWidget {
  const DuasListas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LocalKey: única entre irmãos')),
      // * As DUAS listas usam ValueKey('a') e ValueKey('b'). Não há conflito:
      //   a unicidade da LocalKey é só entre os filhos do MESMO pai. Fora
      //   daquela coluna, a key nem "existe" para o framework.
      body: const Row(
        children: [
          Expanded(child: _ListaSimples(titulo: 'Lista A')),
          VerticalDivider(width: 1),
          Expanded(child: _ListaSimples(titulo: 'Lista B')),
        ],
      ),
    );
  }
}

class _ListaSimples extends StatelessWidget {
  const _ListaSimples({required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(titulo, style: Theme.of(context).textTheme.titleMedium),
        ),
        // Cada filho ganha uma ValueKey. Aqui ela só precisa se distinguir dos
        // IRMÃOS desta coluna -- 'a' e 'b'. A outra lista repete as mesmas keys
        // e continua tudo certo.
        const ListTile(key: ValueKey('a'), title: Text('Item a')),
        const ListTile(key: ValueKey('b'), title: Text('Item b')),
      ],
    );
  }
}
