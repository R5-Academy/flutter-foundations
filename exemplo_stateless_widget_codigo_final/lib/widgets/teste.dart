import 'package:flutter/material.dart';

class Teste extends StatelessWidget {
  const Teste({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // CHEIRO 2 — NOME PRÓPRIO: este bloco É "o cabeçalho do pedido".
                //   Quando um trecho tem nome natural, ele quer virar um widget.
                const Text(
                  'Pedido #1042',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Confirmado em 06/07/2026',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),

                // CHEIRO 3 — REPETIÇÃO: cada "linha de item" abaixo é o MESMO bloco
                //   (Padding > Column > 2 Text), só mudam os dados. Copiar/colar UI
                //   é o aviso mais barato de que falta uma peça parametrizada.
                const Padding(
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
                const Padding(
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
                const Padding(
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
                const SizedBox(height: 16),

                // CHEIRO 4 — OUTRA RESPONSABILIDADE grudada: agora é "o rodapé com
                //   o total". Cabeçalho + itens + total são assuntos diferentes
                //   empilhados no mesmo build.
                const Text(
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
