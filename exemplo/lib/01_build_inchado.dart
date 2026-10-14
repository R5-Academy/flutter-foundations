// 01_build_inchado.dart
// PONTO 1 — o gancho: um resumo de pedido montado INTEIRO num build só.
// Roda e funciona, mas é o retrato do que NÃO fazer. O objetivo é aprender a
// RECONHECER os sinais ("cheiros") de que um build passou do ponto.
// A refatoração está no 02.
//
// (Column/Padding/DecoratedBox aqui são só o veículo — o foco não é layout.)

import 'package:material_ui/material_ui.dart';

void main() => runApp(
  const MaterialApp(
    home: Scaffold(body: Center(child: ResumoPedido())),
  ),
);

class ResumoPedido extends StatelessWidget {
  const ResumoPedido({super.key});

  @override
  Widget build(BuildContext context) {
    // CHEIRO 1 — PROFUNDIDADE: conte os child/children até o primeiro Text.
    //   Se você se perde no caminho, o build está fundo demais.
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
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
    );
  }
}
