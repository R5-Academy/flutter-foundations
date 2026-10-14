// 04_setstate_apos_dispose.dart
// Demonstra: o erro classico "setState() called after dispose()". E a
//   consequencia direta de nao cancelar um Timer que chama setState: depois que
//   a tela sai, o tick dispara num State morto e o framework reclama (erro
//   vermelho no console). A correcao e o mesmo par: cancelar no dispose.
// Enquanto o 03 mostrava o vazamento silencioso, aqui o esquecimento VIRA CRASH.

import 'dart:async';

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaContador()));

class TelaContador extends StatefulWidget {
  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
}

class _TelaContadorState extends State<TelaContador> {
  bool _bugado = false;
  bool _corrigido = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('setState apos dispose')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Ligue um contador, espere ele subir, entao DESLIGUE. '
              'O bugado dispara o erro ~1s depois de sair; o corrigido, nada.',
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Contador BUGADO (sem cancel)'),
              value: _bugado,
              onChanged: (v) => setState(() => _bugado = v),
            ),
            if (_bugado) const ContadorBugado(),
            const Divider(height: 32),
            SwitchListTile(
              title: const Text('Contador CORRIGIDO (cancel no dispose)'),
              value: _corrigido,
              onChanged: (v) => setState(() => _corrigido = v),
            ),
            if (_corrigido) const ContadorCorrigido(),
          ],
        ),
      ),
    );
  }
}

// ! O JEITO ERRADO: o Timer chama setState, mas nunca e cancelado. Ao desligar o
//   switch, o State e descartado (dispose). No proximo tick o timer chama
//   setState num State que ja saiu -> "setState() called after dispose()".
class ContadorBugado extends StatefulWidget {
  const ContadorBugado({super.key});

  @override
  State<ContadorBugado> createState() => _ContadorBugadoState();
}

class _ContadorBugadoState extends State<ContadorBugado> {
  int _segundos = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (_) {
      // Depois do dispose, este setState explode: o widget nao esta mais na tela.
      setState(() => _segundos++);
    });
  }

  @override
  Widget build(BuildContext context) => Text('Bugado: $_segundos s');
}

// * O JEITO CERTO: guarda o Timer e cancela no dispose. Sem tick apos a saida,
//   nao ha setState num State morto -- e nenhum erro. (O guard `if (!mounted)`
//   dentro do callback e um cinto de seguranca extra; a raiz e o cancel.)
class ContadorCorrigido extends StatefulWidget {
  const ContadorCorrigido({super.key});

  @override
  State<ContadorCorrigido> createState() => _ContadorCorrigidoState();
}

class _ContadorCorrigidoState extends State<ContadorCorrigido> {
  Timer? _timer;
  int _segundos = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return; // cinto de seguranca
      setState(() => _segundos++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // a raiz da correcao: sem tick apos a saida
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Text('Corrigido: $_segundos s');
}
