// 02_uma_vez_vs_n_vezes.dart
// Demonstra: a prova visual de que createState roda UMA vez e build roda N vezes.
// Novo em relacao ao 01: colocamos debugPrint dentro de createState e de build
//   e olhamos o CONSOLE ao clicar. E isso que explica por que o estado persiste:
//   o State nao e recriado a cada frame porque createState nao repete.

import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MaterialApp(home: ContadorComLog()));
}

class ContadorComLog extends StatefulWidget {
  const ContadorComLog({super.key});

  // O proprio Flutter tem um lint (no_logic_in_create_state) que diz: nao ponha
  // logica aqui, createState e so uma fabrica. Estamos quebrando a regra DE
  // PROPOSITO, so pra provar que ele roda 1x — por isso o ignore abaixo.
  @override
  // ignore: no_logic_in_create_state
  State<ContadorComLog> createState() {
    // ! Este print aparece UMA UNICA vez, no nascimento do State.
    //   Nao importa quantas vezes voce clique depois: createState nao volta.
    debugPrint('>>> createState — o State nasceu (1x)');
    return _ContadorComLogState();
  }
}

class _ContadorComLogState extends State<ContadorComLog> {
  int _valor = 0;

  @override
  Widget build(BuildContext context) {
    // Este print aparece a CADA rebuild: uma vez ao abrir e mais uma a cada clique.
    debugPrint('    build — desenhando com _valor = $_valor');
    return Scaffold(
      appBar: AppBar(title: const Text('Olhe o console')),
      body: Center(
        child: Text('$_valor', style: const TextStyle(fontSize: 48)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _valor++),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Ao abrir a tela e clicar 3 vezes, o console mostra:
//
//   >>> createState — o State nasceu (1x)
//       build — desenhando com _valor = 0
//       build — desenhando com _valor = 1
//       build — desenhando com _valor = 2
//       build — desenhando com _valor = 3
//
// * Um createState, muitos build. O State e o mesmo objeto o tempo todo -> por
//   isso o _valor sobrevive. Se createState rodasse a cada build, zeraria sempre.
