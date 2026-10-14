// total_pedido.dart
// Uma responsabilidade só: exibir o total do pedido.

import 'package:material_ui/material_ui.dart';

class TotalPedido extends StatelessWidget {
  const TotalPedido({super.key, required this.valor});

  final String valor;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Total: $valor',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
