// seletor_cores.dart
// O título "Cores" + a linha de chips. Recebe a lista de cores e monta um
// ChipCor para cada uma. Um widget que COMPÕE outro widget (ChipCor) — cada um
// no seu arquivo.

import 'package:material_ui/material_ui.dart';

import 'chip_cor.dart';

class SeletorCores extends StatelessWidget {
  const SeletorCores({super.key, required this.cores});

  final List<String> cores;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cores',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            for (final cor in cores) ...[
              ChipCor(cor: cor),
              const SizedBox(width: 8),
            ],
          ],
        ),
      ],
    );
  }
}
