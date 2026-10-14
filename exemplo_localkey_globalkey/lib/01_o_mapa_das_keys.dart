// 01_o_mapa_das_keys.dart
// Demonstra: o MAPA dos tipos de Key. A classe Key é abstrata e obriga a
//   escolher um lado -- LocalKey ou GlobalKey. Mostra também que Key('x') é,
//   por baixo, uma ValueKey<String>.
// Ponto de partida da aula: só o desenho da árvore. Nada de estado ainda.

import 'package:material_ui/material_ui.dart';

// * A árvore de tipos de Key (confirmada na api.flutter.dev):
//
//   Key                       (abstrata)
//    |-- LocalKey             (abstrata) -- única ENTRE IRMÃOS, barata
//    |    |-- ValueKey<T>             identidade = um valor (==)
//    |    |    '-- PageStorageKey<T>  ValueKey especializada (scroll)
//    |    |-- ObjectKey               identidade = a instância (identical)
//    |    '-- UniqueKey               identidade = só ela mesma
//    '-- GlobalKey<T>         (abstrata) -- única NO APP INTEIRO, cara
//         |-- LabeledGlobalKey<T>    o que GlobalKey() devolve por baixo
//         '-- GlobalObjectKey<T>     identidade = identical(objeto)

void main() => runApp(const MaterialApp(home: MapaDasKeys()));

class MapaDasKeys extends StatelessWidget {
  const MapaDasKeys({super.key});

  @override
  Widget build(BuildContext context) {
    // Key('abc') é um FACTORY: ele devolve um ValueKey<String>. Por isso
    // escrever const Key('...') sempre foi usar uma ValueKey disfarçada.
    const k = Key('abc');

    final linhas = <String>[
      "const Key('abc') é, na verdade:",
      '  ${k.runtimeType}',
      '',
      'ValueKey(10)     -> ${const ValueKey(10).runtimeType}',
      'ObjectKey(obj)   -> ${ObjectKey(Object()).runtimeType}',
      'UniqueKey()      -> ${UniqueKey().runtimeType}',
      'GlobalKey()      -> ${GlobalKey().runtimeType}',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('O mapa das Keys')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final linha in linhas)
              Text(
                linha,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
