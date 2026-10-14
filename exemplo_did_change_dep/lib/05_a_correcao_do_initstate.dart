// 05_a_correcao_do_initstate.dart
// Demonstra: fecha o arco aberto na aula de initState. Aquela leitura de
//   Theme.of/MediaQuery.of que QUEBRAVA dentro do initState tem um lar certo:
//   o didChangeDependencies. Aqui e legal, roda antes do 1o build e ainda
//   reage quando a dependencia muda.
// Novo em relacao ao 04: junta tudo -- o par mental "depende de ancestral
//   herdado? vai no didChangeDependencies, nao no initState".

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppCorrecao());

class AppCorrecao extends StatefulWidget {
  const AppCorrecao({super.key});

  @override
  State<AppCorrecao> createState() => _AppCorrecaoState();
}

class _AppCorrecaoState extends State<AppCorrecao> {
  bool _escuro = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: _escuro ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('O lugar certo da leitura')),
        body: const PainelBoasVindas(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => setState(() => _escuro = !_escuro),
          label: const Text('Trocar tema'),
          icon: const Icon(Icons.brightness_6),
        ),
      ),
    );
  }
}

class PainelBoasVindas extends StatefulWidget {
  const PainelBoasVindas({super.key});

  @override
  State<PainelBoasVindas> createState() => _PainelBoasVindasState();
}

class _PainelBoasVindasState extends State<PainelBoasVindas> {
  late String _saudacao;
  late Color _cor;

  @override
  void initState() {
    super.initState();
    // ! NAO leia dependencia herdada aqui. Descomentar quebra em debug com
    //   "dependOnInheritedWidgetOfExactType... before initState completed".
    //
    // _cor = Theme.of(context).colorScheme.primary;

    // O que NAO depende de ancestral pode ficar no initState normalmente.
    _saudacao = 'Bem-vindo!';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // * Aqui e o lugar certo: Theme.of e seguro, roda antes do 1o build e
    //   recalcula a cor toda vez que o tema muda.
    _cor = Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.waving_hand, size: 64, color: _cor),
          const SizedBox(height: 12),
          Text(_saudacao, style: TextStyle(fontSize: 24, color: _cor)),
        ],
      ),
    );
  }
}
