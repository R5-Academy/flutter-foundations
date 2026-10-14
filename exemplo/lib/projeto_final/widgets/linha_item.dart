// linha_item.dart
// Uma linha de item do pedido (nome + preço). Peça parametrizada e reutilizável.

import 'package:material_ui/material_ui.dart';

class LinhaItem extends StatelessWidget {
  const LinhaItem({super.key, required this.nome, required this.preco});

  final String nome;
  final String preco;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(nome, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(preco),
        ],
      ),
    );
  }
}
