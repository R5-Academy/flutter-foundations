// 05_safe_area_e_teclado.dart
// Demonstra: os paddings do sistema. Duas coisas diferentes que muita gente
//   confunde:
//   - MediaQuery.paddingOf(context)  -> a SAFE AREA (status bar, notch). E o que
//     o widget SafeArea usa por baixo dos panos.
//   - MediaQuery.viewInsetsOf(context).bottom -> o TECLADO. Quanto ele cobre por
//     baixo quando esta aberto.
//
// * Regra: safe area -> padding; teclado -> viewInsets.
//
// O campo de mensagem fica colado na base e SOBE junto com o teclado, porque a
// gente da um padding de baixo igual ao viewInsets.bottom.
//
// Obs.: desligamos o resizeToAvoidBottomInset (que por padrao ja faria isso
// sozinho) so para fazer o ajuste NA MAO e enxergar o mecanismo. No dia a dia,
// deixar o padrao ligado costuma bastar.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppSafeAreaTeclado());

class AppSafeAreaTeclado extends StatelessWidget {
  const AppSafeAreaTeclado({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe area e teclado',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TelaChat(),
    );
  }
}

class TelaChat extends StatelessWidget {
  const TelaChat({super.key});

  @override
  Widget build(BuildContext context) {
    // Especificos: um so reconstroi com a safe area, o outro so com o teclado.
    final safeArea = MediaQuery.paddingOf(context);
    final teclado = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      // Desligado de proposito para ajustarmos o teclado na mao (ver header).
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Mensagens')),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Paddings do sistema',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Divider(),
                      // Safe area: costuma ter valor no topo (status bar/notch).
                      Text(
                        'Safe area topo: ${safeArea.top.toStringAsFixed(0)}',
                      ),
                      Text(
                        'Safe area base: '
                        '${safeArea.bottom.toStringAsFixed(0)}',
                      ),
                      const SizedBox(height: 8),
                      // Teclado: 0 quando fechado, > 0 quando aberto.
                      Text(
                        'Teclado (viewInsets.bottom): '
                        '${teclado.toStringAsFixed(0)}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // O campo sobe junto com o teclado: padding de baixo = altura do teclado.
          Padding(
            padding: EdgeInsets.only(bottom: teclado),
            child: Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Escreva uma mensagem...',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: () {},
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
