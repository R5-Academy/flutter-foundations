// 05_mundo_real_card.dart
// Demonstra: StatelessWidget com cara de app de verdade — um card de produto.
// Novo em relação ao 04: mais de um dado no construtor e composição de vários
//   widgets. Continua sendo pura composição: UI = f(dados).
//
// A régua mental: este card SÓ exibe o que recebe. Não conta nada, não muda
// sozinho, não guarda estado -> é o caso perfeito de StatelessWidget.

import 'package:material_ui/material_ui.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          // const: mesma instância reaproveitada entre rebuilds.
          child: CardProduto(
            nome: 'Fone Bluetooth',
            preco: 199.90,
            emEstoque: true,
          ),
        ),
      ),
    ),
  );
}

class CardProduto extends StatelessWidget {
  const CardProduto({
    super.key,
    required this.nome,
    required this.preco,
    required this.emEstoque,
  });

  // Todos os dados chegam prontos, pelo construtor, e são final.
  final String nome;
  final double preco;
  final bool emEstoque;

  @override
  Widget build(BuildContext context) {
    // build é PURO: transforma (nome, preco, emEstoque) em widgets. Sem IO,
    // sem estado, sem efeito colateral.
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nome,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('R\$ ${preco.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text(
              emEstoque ? 'Em estoque' : 'Esgotado',
              style: TextStyle(color: emEstoque ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
