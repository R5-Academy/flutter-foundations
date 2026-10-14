// exemplo_01_anatomia_objectkey.dart
// Demonstra: o que a ObjectKey e' por dentro -- identidade por REFERENCIA.
//   Enquanto a ValueKey compara com == (o valor), a ObjectKey compara com
//   identical(a, b): so casa se for a MESMA instancia na memoria.
// Novo em relacao a aula de ValueKey: aqui a key nao pergunta "esse valor e'
//   igual?", e sim "e' o mesmo objeto?". A tela abaixo mostra os dois lados.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaComparacoes()));

// Um modelo com == sobrescrito: dois "Ana" de mesmo conteudo sao == (iguais),
// mesmo sendo instancias diferentes. E' aqui que ValueKey e ObjectKey divergem.
class Pessoa {
  const Pessoa(this.nome);

  final String nome;

  @override
  bool operator ==(Object other) => other is Pessoa && other.nome == nome;

  @override
  int get hashCode => nome.hashCode;
}

class TelaComparacoes extends StatelessWidget {
  const TelaComparacoes({super.key});

  @override
  Widget build(BuildContext context) {
    // Duas instancias DIFERENTES, porem de conteudo igual (== da true).
    final ana1 = const Pessoa('Ana');
    final ana2 = const Pessoa('Ana');

    // ! const Pessoa('Ana') e' canonizado pelo Dart: as duas constantes viram
    //   a MESMA instancia. Por isso criamos copias em runtime para o exemplo:
    final anaA = Pessoa('Ana');
    final anaB = Pessoa('Ana');

    final comparacoes = <_Comparacao>[
      _Comparacao(
        titulo: 'ValueKey(anaA) == ValueKey(anaB)',
        // ValueKey usa o == do valor: anaA == anaB e' true (mesmo conteudo).
        resultado: ValueKey(anaA) == ValueKey(anaB),
        explicacao: 'true -- compara por VALOR (== da Pessoa)',
      ),
      _Comparacao(
        titulo: 'ObjectKey(anaA) == ObjectKey(anaB)',
        // ObjectKey usa identical(): anaA e anaB sao instancias distintas.
        resultado: ObjectKey(anaA) == ObjectKey(anaB),
        explicacao: 'false -- compara por REFERENCIA (identical)',
      ),
      _Comparacao(
        titulo: 'ObjectKey(anaA) == ObjectKey(anaA)',
        // A mesma instancia dos dois lados: identical da true.
        resultado: ObjectKey(anaA) == ObjectKey(anaA),
        explicacao: 'true -- e o MESMO objeto',
      ),
      _Comparacao(
        titulo: 'identical(anaA, anaB)',
        resultado: identical(anaA, anaB),
        explicacao: 'false -- instancias diferentes',
      ),
      _Comparacao(
        titulo: 'anaA == anaB (o == da Pessoa)',
        resultado: anaA == anaB,
        explicacao: 'true -- mesmo conteudo (== sobrescrito)',
      ),
      _Comparacao(
        titulo: 'const: identical(ana1, ana2)',
        resultado: identical(ana1, ana2),
        explicacao: 'true -- const iguais viram a MESMA instancia',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('ObjectKey: identidade por referencia')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'ValueKey pergunta "esse valor e igual?".\n'
            'ObjectKey pergunta "e o mesmo objeto?".',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          for (final c in comparacoes) _CartaoComparacao(c),
          const SizedBox(height: 8),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'ObjectKey NAO e generica: o construtor recebe Object? value. '
                'ObjectKey<Pessoa>(p) nao compila.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Comparacao {
  const _Comparacao({
    required this.titulo,
    required this.resultado,
    required this.explicacao,
  });

  final String titulo;
  final bool resultado;
  final String explicacao;
}

class _CartaoComparacao extends StatelessWidget {
  const _CartaoComparacao(this.c);

  final _Comparacao c;

  @override
  Widget build(BuildContext context) {
    final cor = c.resultado ? Colors.green : Colors.red;
    return Card(
      child: ListTile(
        leading: Icon(
          c.resultado ? Icons.check_circle : Icons.cancel,
          color: cor,
        ),
        title: Text(c.titulo, style: const TextStyle(fontFamily: 'monospace')),
        subtitle: Text(c.explicacao),
        trailing: Text(
          c.resultado ? 'true' : 'false',
          style: TextStyle(color: cor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
