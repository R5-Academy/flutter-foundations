// pagina_01_resumo_pedido_inchado.dart
// Exemplo 01 — o "antes": um resumo de pedido montado inteiro num build só
// (cabeçalho + itens repetidos + total). Versão página, sem main/runApp.

import 'package:material_ui/material_ui.dart';

class PaginaResumoPedidoInchado extends StatelessWidget {
  const PaginaResumoPedidoInchado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumo do pedido (inchado)')),
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
                // cabeçalho
                Text(
                  'Pedido #1042',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Confirmado em 06/07/2026',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 16),
                // itens (blocos repetidos — o "cheiro" que pede extração)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Camiseta Flutter',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text('R\$ 79,90'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Caneca Dart',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text('R\$ 39,90'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Adesivos (pacote)',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text('R\$ 19,90'),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Total: R\$ 139,70',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
