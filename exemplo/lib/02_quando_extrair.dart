// 02_quando_extrair.dart
// PONTO 1 — o "depois": o mesmo resumo do 01, agora quebrado em widgets por
// RESPONSABILIDADE. A tela é idêntica; o código é outro mundo.
//
// ORGANIZAÇÃO: cada widget extraído mora em seu PRÓPRIO ARQUIVO, na pasta
// `02_quando_extrair/` ao lado deste. Este arquivo só importa as peças e as
// compõe — é assim que um projeto de verdade se organiza (um widget por arquivo).
//
// QUANDO EXTRAIR? Os sinais do 01 viram regra de bolso:
//   • Perdeu a conta do aninhamento     → fundo demais, extraia.
//   • O bloco tem um nome natural         → esse nome vira o widget (e o arquivo).
//   • O mesmo bloco se repete             → UMA peça parametrizada.
//   • Responsabilidades diferentes juntas → uma peça para cada.
//
// Dica: no VS Code, cursor no widget → Ctrl/Cmd + . → "Extract Widget". No
// Android Studio, Alt+Enter → "Extract Flutter Widget".

import 'package:material_ui/material_ui.dart';

import '02_quando_extrair/cabecalho_pedido.dart';
import '02_quando_extrair/linha_item.dart';
import '02_quando_extrair/total_pedido.dart';

void main() => runApp(
  const MaterialApp(
    home: Scaffold(body: Center(child: ResumoPedido())),
  ),
);

// O build principal agora se LÊ COMO UMA FRASE: um cabeçalho, três itens e um
// total. Quem lê entende a tela sem descer no detalhe de cada peça.
class ResumoPedido extends StatelessWidget {
  const ResumoPedido({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
    );
  }
}
