// pagina_02_resumo_pedido.dart
// Exemplo 02 — o "depois": o mesmo resumo, composto por widgets pequenos de
// widgets/ (CabecalhoPedido, LinhaItem, TotalPedido). O build lê como uma frase.

import 'package:material_ui/material_ui.dart';

import '../widgets/cabecalho_pedido.dart';
import '../widgets/linha_item.dart';
import '../widgets/total_pedido.dart';

class PaginaResumoPedido extends StatelessWidget {
  const PaginaResumoPedido({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumo do pedido')),
      body: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CabecalhoPedido(numero: '1042', data: '06/07/2026'),
                SizedBox(height: 16),
                LinhaItem(nome: 'Camiseta Flutter', preco: 'R\$ 79,90'),
                LinhaItem(nome: 'Caneca Dart', preco: 'R\$ 39,90'),
                LinhaItem(nome: 'Adesivos (pacote)', preco: 'R\$ 19,90'),
                SizedBox(height: 16),
                TotalPedido(valor: 'R\$ 139,70'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
