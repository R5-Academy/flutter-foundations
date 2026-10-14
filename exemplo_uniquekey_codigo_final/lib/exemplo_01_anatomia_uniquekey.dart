// exemplo_01_anatomia_uniquekey.dart
// Demonstra: o que a UniqueKey e' por dentro -- uma key que so e' igual a si
//   mesma. Ela nao recebe valor: nao ha o que comparar. Por isso duas UniqueKey,
//   mesmo criadas na mesma linha, NUNCA sao iguais. E' o oposto de ValueKey e
//   ObjectKey, que existem justamente para "reconhecer" um widget e preservar
//   o estado.
// Novo em relacao a ObjectKey: aqui a identidade nao serve para preservar, e sim
//   para GARANTIR que o Flutter trate o widget como novo (proximos exemplos).

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaAnatomia()));

class TelaAnatomia extends StatelessWidget {
  const TelaAnatomia({super.key});

  @override
  Widget build(BuildContext context) {
    // Duas UniqueKey criadas lado a lado -- e ainda assim diferentes.
    final a = UniqueKey();
    final b = UniqueKey();

    final obj = Object();

    final linhas = <_Linha>[
      _Linha('a == a', a == a, 'true -- so e igual a si mesma'),
      _Linha('a == b', a == b, 'false -- nunca igual a outra, mesmo criadas juntas'),
      _Linha('ValueKey(1) == ValueKey(1)', ValueKey(1) == ValueKey(1),
          'true -- ValueKey compara por VALOR'),
      _Linha('ObjectKey(obj) == ObjectKey(obj)', ObjectKey(obj) == ObjectKey(obj),
          'true -- ObjectKey compara a MESMA instancia'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('UniqueKey: so igual a si mesma')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'ValueKey e ObjectKey dizem "e o mesmo, preserve".\n'
            'UniqueKey diz "esquece, comeca de novo".',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          for (final l in linhas)
            Card(
              child: ListTile(
                leading: Icon(
                  l.resultado ? Icons.check_circle : Icons.cancel,
                  color: l.resultado ? Colors.green : Colors.red,
                ),
                title: Text(l.expressao,
                    style: const TextStyle(fontFamily: 'monospace')),
                subtitle: Text(l.explicacao),
              ),
            ),
          const SizedBox(height: 8),
          const Card(
            color: Color(0xFFFFF3E0),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'const UniqueKey() NAO compila: um construtor const faria todas '
                'as instancias serem a mesma -- e ai deixariam de ser unicas.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Linha {
  const _Linha(this.expressao, this.resultado, this.explicacao);

  final String expressao;
  final bool resultado;
  final String explicacao;
}
