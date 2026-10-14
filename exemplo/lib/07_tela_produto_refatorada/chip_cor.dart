// chip_cor.dart
// UM chip de cor. A repetição dos três Containers idênticos do 06 virou esta
// peça única, parametrizada pela cor. É usada dentro de seletor_cores.dart.

import 'package:material_ui/material_ui.dart';

class ChipCor extends StatelessWidget {
  const ChipCor({super.key, required this.cor});

  final String cor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(cor),
    );
  }
}
