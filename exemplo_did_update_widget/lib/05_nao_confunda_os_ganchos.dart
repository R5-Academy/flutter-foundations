// 05_nao_confunda_os_ganchos.dart
// Demonstra: didUpdateWidget x didChangeDependencies x setState, lado a lado.
//   - prop do proprio widget muda (o pai passou outra) -> didUpdateWidget
//   - dependencia herdada via context muda (Theme)      -> didChangeDependencies
//   - setState interno do proprio State                 -> so build
// Novo em relacao ao 02-04: fecha o modelo mental separando os tres gatilhos.
//   Deixe o console a vista e clique em cada botao observando quem dispara.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppRaiz());

class AppRaiz extends StatefulWidget {
  const AppRaiz({super.key});

  @override
  State<AppRaiz> createState() => _AppRaizState();
}

class _AppRaizState extends State<AppRaiz> {
  int _rotulo = 0; // vira prop do filho (muda -> didUpdateWidget)
  bool _escuro = false; // muda o Theme (muda -> didChangeDependencies)

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: _escuro ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Nao confunda os ganchos')),
        body: Center(child: Sonda(rotulo: _rotulo)),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              heroTag: 'prop',
              onPressed: () => setState(() => _rotulo++),
              label: const Text('Mudar a prop'),
              icon: const Icon(Icons.tag),
            ),
            const SizedBox(height: 12),
            FloatingActionButton.extended(
              heroTag: 'tema',
              onPressed: () => setState(() => _escuro = !_escuro),
              label: const Text('Trocar tema'),
              icon: const Icon(Icons.brightness_6),
            ),
          ],
        ),
      ),
    );
  }
}

class Sonda extends StatefulWidget {
  const Sonda({super.key, required this.rotulo});

  final int rotulo;

  @override
  State<Sonda> createState() => _SondaState();
}

class _SondaState extends State<Sonda> {
  int _cliquesInternos = 0;

  // Dispara quando o PAI muda a prop rotulo.
  @override
  void didUpdateWidget(covariant Sonda oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('didUpdateWidget  <- a prop mudou (pai)');
  }

  // Dispara quando uma dependencia HERDADA via context muda (aqui, o Theme).
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('didChangeDependencies  <- tema/herdado mudou');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Prop (rotulo): ${widget.rotulo}'),
        const SizedBox(height: 8),
        Text('Cliques internos: $_cliquesInternos'),
        const SizedBox(height: 16),
        FilledButton(
          // setState interno: nao passa por nenhum dos dois ganchos, so build.
          onPressed: () => setState(() => _cliquesInternos++),
          child: const Text('setState interno (so build)'),
        ),
      ],
    );
  }
}
