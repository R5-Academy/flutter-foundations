// 01_of_por_dentro.dart
// Demonstra: que Theme.of(context) NAO e magica. Ele so sobe a arvore procurando
//   o Theme ancestral. Aqui mostramos o resultado do .of pronto ao lado do jeito
//   cru (context.findAncestorWidgetOfExactType<Theme>()) para provar que dao o mesmo.
// Novo em relacao a aula anterior: la a gente CONSUMIU o .of; aqui a gente abre a
//   caixa e ve o metodo generico que ele usa por baixo.

import 'package:material_ui/material_ui.dart';

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

    // * O mesmo movimento, escrito na mao: acha o WIDGET Theme subindo a arvore
    // * e le o .data dele. findAncestorWidgetOfExactType e o metodo generico que
    // * o Theme.of usa por baixo. O '?' existe porque, se nao houver Theme acima,
    // * o retorno e null.
    final themeCru = context.findAncestorWidgetOfExactType<Theme>();
    final corCrua = themeCru?.data.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('.of por dentro')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Amostra(rotulo: 'Theme.of(context)', cor: corDoOf),
            const SizedBox(height: 24),
            _Amostra(rotulo: 'findAncestorWidgetOfExactType', cor: corCrua),
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
