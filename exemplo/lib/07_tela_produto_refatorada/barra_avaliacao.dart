// barra_avaliacao.dart
// As estrelas + o texto da nota. Recebe a nota e o total pelo construtor e
// calcula quantas estrelas cheias/meia mostrar. Bom exemplo de widget com
// construtor `const` mas conteúdo dinâmico (as estrelas dependem da nota).

import 'package:material_ui/material_ui.dart';

class BarraAvaliacao extends StatelessWidget {
  const BarraAvaliacao({
    super.key,
    required this.nota,
    required this.totalAvaliacoes,
  });

  final double nota;
  final int totalAvaliacoes;

  @override
  Widget build(BuildContext context) {
    final cheias = nota.floor();
    final temMeia = (nota - cheias) >= 0.5;
    return Row(
      children: [
        for (var i = 0; i < 5; i++)
          Icon(
            i < cheias
                ? Icons.star
                : (i == cheias && temMeia
                      ? Icons.star_half
                      : Icons.star_border),
            color: Colors.amber,
            size: 20,
          ),
        const SizedBox(width: 8),
        Text(
          '$nota ($totalAvaliacoes avaliações)',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
