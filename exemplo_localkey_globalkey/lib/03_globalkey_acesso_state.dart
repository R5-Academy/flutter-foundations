// 03_globalkey_acesso_state.dart
// Demonstra: o superpoder (a) da GlobalKey -- acessar o State de um filho por
//   FORA do build, via key.currentState. Um cofrinho guarda o próprio saldo;
//   um botão no PAI deposita nele, sem callback e sem levantar o estado.
// Novo em relação ao 02: aqui a key deixa de ser só identidade e vira uma
//   "alça" para o State. Isso é exclusivo da GlobalKey -- ValueKey não tem.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaCofrinho()));

class TelaCofrinho extends StatefulWidget {
  const TelaCofrinho({super.key});

  @override
  State<TelaCofrinho> createState() => _TelaCofrinhoState();
}

class _TelaCofrinhoState extends State<TelaCofrinho> {
  // * A GlobalKey é tipada com o State do filho (CofrinhoState). É esse <T> que
  //   dá tipo ao currentState. Declarada AQUI, no State -- nunca no build.
  final _cofrinhoKey = GlobalKey<CofrinhoState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GlobalKey: alça para o State')),
      body: Center(child: Cofrinho(key: _cofrinhoKey)),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Depositar R\$ 5'),
        icon: const Icon(Icons.savings),
        // Falamos com o State do filho por fora do build. currentState é
        // NULLABLE: retorna null se nada com essa key estiver montado agora.
        onPressed: () => _cofrinhoKey.currentState?.depositar(5),
      ),
    );
  }
}

// ? Repare que o State é PÚBLICO (CofrinhoState, sem underline). É o que
//   permite tipar GlobalKey<CofrinhoState> e chamar seus métodos de fora.
class Cofrinho extends StatefulWidget {
  const Cofrinho({super.key});

  @override
  State<Cofrinho> createState() => CofrinhoState();
}

class CofrinhoState extends State<Cofrinho> {
  int saldo = 0; // o estado mora aqui, no Element -- não vem por parâmetro

  void depositar(int valor) => setState(() => saldo += valor);

  @override
  Widget build(BuildContext context) {
    return Text('Saldo: R\$ $saldo', style: const TextStyle(fontSize: 32));
  }
}
