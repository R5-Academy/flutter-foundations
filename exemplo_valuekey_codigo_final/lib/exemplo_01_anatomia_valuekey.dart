// exemplo_01_anatomia_valuekey.dart
// Demonstra: o que a ValueKey e' por dentro -- identidade POR VALOR. Duas
//   ValueKey sao iguais quando o `==` dos valores da true (e o runtimeType da
//   key, que inclui o generico <T>, tambem bate). Mostra tambem que Key('x') e'
//   so um atalho (factory) para ValueKey<String>('x').
// Esta e' a primeira aula que abre a ValueKey em si; as anteriores mostraram o
//   PROBLEMA (reconciliacao) e o MAPA dos tipos. Aqui a lupa e' na igualdade.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaAnatomia()));

class TelaAnatomia extends StatelessWidget {
  const TelaAnatomia({super.key});

  @override
  Widget build(BuildContext context) {
    // * Key('salvar') e' identico a ValueKey<String>('salvar'). A classe
    //   abstrata Key tem uma factory: const factory Key(String v) = ValueKey<String>.
    // O `==` da ValueKey roda em runtime (nao e' const), por isso comparamos
    // aqui, dentro do build, e nao em constantes.
    const Key comAtalho = Key('salvar');
    const Key semAtalho = ValueKey<String>('salvar');

    // O generico <T> faz parte da identidade: um int nao casa com uma String.
    // Tipamos como Key para comparar sem o aviso de "tipos nao relacionados".
    const Key chaveInt = ValueKey<int>(1);
    const Key chaveString = ValueKey<String>('1');

    final comparacoes = <(String, bool)>[
      ("Key('salvar') == ValueKey<String>('salvar')", comAtalho == semAtalho),
      (
        "ValueKey('ana@x') == ValueKey('ana@x')",
        const ValueKey('ana@x.com') == const ValueKey('ana@x.com'),
      ),
      ('ValueKey(1) == ValueKey(1)', const ValueKey(1) == const ValueKey(1)),
      ('ValueKey(1) == ValueKey(2)', const ValueKey(1) == const ValueKey(2)),
      ("ValueKey<int>(1) == ValueKey<String>('1')", chaveInt == chaveString),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Anatomia da ValueKey')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'ValueKey compara por VALOR (o == do valor guardado):',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          for (final (expressao, resultado) in comparacoes)
            ListTile(
              leading: Icon(
                resultado ? Icons.check_circle : Icons.cancel,
                color: resultado ? Colors.green : Colors.red,
              ),
              title: Text(
                expressao,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
              trailing: Text(
                '$resultado',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
