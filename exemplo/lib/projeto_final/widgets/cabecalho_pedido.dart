// cabecalho_pedido.dart
// Uma responsabilidade só: o cabeçalho do pedido (número + data).

import 'package:material_ui/material_ui.dart';

class CabecalhoPedido extends StatelessWidget {
  const CabecalhoPedido({super.key, required this.numero, required this.data});

  final String numero;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Pedido #$numero',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text('Confirmado em $data', style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
