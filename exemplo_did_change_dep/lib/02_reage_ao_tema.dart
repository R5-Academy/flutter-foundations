// 02_reage_ao_tema.dart
// Demonstra: o didChangeDependencies roda DE NOVO quando uma dependencia
//   herdada muda. Aqui a dependencia e o Theme: ao alternar claro/escuro, o
//   metodo dispara outra vez e recalcula um valor derivado do tema.
// Novo em relacao ao 01: nao e so "roda uma vez apos o initState" -- ele reage.
//   E, ao contrario do initState, aqui Theme.of(context) e SEGURO.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppTema());

class AppTema extends StatefulWidget {
  const AppTema({super.key});

  @override
  State<AppTema> createState() => _AppTemaState();
}

class _AppTemaState extends State<AppTema> {
  bool _escuro = false;

  @override
  Widget build(BuildContext context) {
    // O MaterialApp e quem carrega o tema (um InheritedWidget por baixo). Trocar
    // o ThemeData aqui e o que faz a dependencia la embaixo "mudar".
    return MaterialApp(
      theme: ThemeData(
        brightness: _escuro ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Reagindo ao tema')),
        body: const CartaoResumo(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => setState(() => _escuro = !_escuro),
          label: const Text('Trocar tema'),
          icon: const Icon(Icons.brightness_6),
        ),
      ),
    );
  }
}

class CartaoResumo extends StatefulWidget {
  const CartaoResumo({super.key});

  @override
  State<CartaoResumo> createState() => _CartaoResumoState();
}

class _CartaoResumoState extends State<CartaoResumo> {
  // Valor derivado do tema, guardado no State para nao recalcular a cada build.
  late Color _corDeFundo;
  int _vezes = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _vezes++;
    // Seguro chamar Theme.of aqui. Roda na 1a vez (antes do 1o build) e de novo
    // sempre que o tema mudar -- por isso a cor acompanha o claro/escuro.
    _corDeFundo = Theme.of(context).colorScheme.primaryContainer;
    debugPrint('didChangeDependencies rodou $_vezes vez(es)');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 220,
        height: 140,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _corDeFundo,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text('Cor recalculada $_vezes vez(es)'),
      ),
    );
  }
}
