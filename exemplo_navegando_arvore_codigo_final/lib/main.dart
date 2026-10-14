import 'package:flutter/material.dart';

void main() => runApp(const AppOfPorDentro());

class AppOfPorDentro extends StatelessWidget {
  const AppOfPorDentro({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TelaComparacao());
  }
}

class TelaComparacao extends StatelessWidget {
  const TelaComparacao({super.key});

  @override
  Widget build(BuildContext context) {
    // * O jeito de sempre: sobe a arvore e traz o ThemeData do Theme ancestral.
    final corDoOf = Theme.of(context).colorScheme.primary;

    final theme = context.findAncestorWidgetOfExactType<Theme>();
    final corCrua = theme?.data.primaryColor;

    return Scaffold(
      appBar: AppBar(title: const Text('.of por dentro')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Amostra(rotulo: 'Theme.of(context)', cor: corDoOf),
            const SizedBox(height: 24),
            _Amostra(rotulo: 'cor Cura', cor: corCrua),
            const SizedBox(height: 24),
            // A cor e identica nos dois: prova de que .of e so uma fachada.
            Text(
              corDoOf == corCrua
                  ? 'Mesma cor: .of e a subida crua batem'
                  : 'Diferentes?!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _Amostra extends StatelessWidget {
  const _Amostra({required this.rotulo, required this.cor});

  final String rotulo;
  final Color? cor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: 120, height: 48, color: cor),
        const SizedBox(height: 8),
        Text(rotulo),
      ],
    );
  }
}
