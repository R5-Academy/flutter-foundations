// 03_controller_no_initstate.dart
// Demonstra: o uso mais comum do initState no dia a dia -- criar um controller
//   UMA vez e assinar um listener nele. Campo de busca que conta os caracteres
//   digitados em tempo real.
// Novo em relacao ao 02: agora criamos um objeto que vive junto com o State
//   (TextEditingController) e reagimos a ele com addListener. Aparece tambem o
//   par espelhado com o dispose (que sera aprofundado em aula futura).

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaBusca()));

class TelaBusca extends StatefulWidget {
  const TelaBusca({super.key});

  @override
  State<TelaBusca> createState() => _TelaBuscaState();
}

class _TelaBuscaState extends State<TelaBusca> {
  // `late final`: final porque nunca troca de instancia; late porque so ganha
  // valor dentro do initState.
  late final TextEditingController _controller;
  int _quantidade = 0;

  @override
  void initState() {
    super.initState();
    // * Criado 1x aqui -- nao no build. Se criassemos no build (que roda a cada
    //   setState), nasceria um controller novo a cada frame: vazamento e o
    //   texto se perderia. initState roda uma vez, entao o controller vive junto
    //   com o State.
    _controller = TextEditingController();
    _controller.addListener(_aoDigitar);
  }

  void _aoDigitar() {
    setState(() => _quantidade = _controller.text.length);
  }

  // ! Espelho do initState: tudo que se cria/assina la, libera-se aqui.
  //   Vamos aprofundar o dispose numa aula proxima; por ora, saiba que o
  //   controller precisa ser liberado para nao vazar memoria.
  @override
  void dispose() {
    _controller.removeListener(_aoDigitar);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Busca')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'O que voce procura?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Text('$_quantidade caracteres digitados'),
          ],
        ),
      ),
    );
  }
}
