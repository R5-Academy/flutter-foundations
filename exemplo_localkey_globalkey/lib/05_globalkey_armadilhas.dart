// 05_globalkey_armadilhas.dart
// Demonstra: as duas armadilhas da GlobalKey. A principal, ao vivo -- criar a
//   key DENTRO do build recria a key a cada frame, destruindo o State que ela
//   deveria preservar. Um botão "Reconstruir" força rebuilds para expor isso.
// Novo em relação ao 04: aqui o foco é o ERRO comum e a forma certa lado a lado.

import 'dart:math';

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: ArmadilhaDemo()));

class ArmadilhaDemo extends StatefulWidget {
  const ArmadilhaDemo({super.key});

  @override
  State<ArmadilhaDemo> createState() => _ArmadilhaDemoState();
}

class _ArmadilhaDemoState extends State<ArmadilhaDemo> {
  // * O JEITO CERTO: a key nasce UMA vez, no State, e sobrevive a todos os builds.
  final _keyCerta = GlobalKey();

  int _rebuilds = 0;

  @override
  Widget build(BuildContext context) {
    // ! O JEITO ERRADO: uma GlobalKey nova a CADA build. Para o framework, a
    //   cada frame é "outro widget" -- ele joga fora o Element e o State antigos
    //   e recria tudo. O benefício da GlobalKey vira prejuízo.
    final keyErrada = GlobalKey();

    // ! ARMADILHA 2 (não dá para mostrar sem quebrar o app): a MESMA GlobalKey
    //   em dois widgets vivos ao mesmo tempo lança, em runtime:
    //     "Multiple widgets used the same GlobalKey."
    //   GlobalKey é única no APP inteiro -- nunca reaproveite a mesma em dois
    //   filhos montados simultaneamente.

    return Scaffold(
      appBar: AppBar(title: const Text('GlobalKey: a armadilha do build')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Aperte "Reconstruir" e observe as cores:'),
          const SizedBox(height: 16),
          _Linha(
            rotulo: 'Key no State (certo)',
            child: QuadradoColorido(key: _keyCerta),
          ),
          _Linha(
            rotulo: 'Key no build (errado)',
            child: QuadradoColorido(key: keyErrada),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => setState(() => _rebuilds++),
            child: Text('Reconstruir ($_rebuilds)'),
          ),
        ],
      ),
    );
  }
}

class _Linha extends StatelessWidget {
  const _Linha({required this.rotulo, required this.child});

  final String rotulo;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 200, child: Text(rotulo)),
          child,
        ],
      ),
    );
  }
}

class QuadradoColorido extends StatefulWidget {
  const QuadradoColorido({super.key});

  @override
  State<QuadradoColorido> createState() => _QuadradoColoridoState();
}

class _QuadradoColoridoState extends State<QuadradoColorido> {
  // A cor é sorteada UMA vez, no nascimento do State. No quadrado "certo" ela
  // fica estável entre rebuilds; no "errado" muda a cada clique -- prova de que
  // o State foi recriado porque a key mudou.
  late final cor = Color(0xFF000000 | Random().nextInt(0xFFFFFF));

  @override
  Widget build(BuildContext context) {
    return Container(width: 60, height: 60, color: cor);
  }
}
