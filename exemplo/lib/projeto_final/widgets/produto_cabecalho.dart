// produto_cabecalho.dart
// Nome + preço do produto. Uma responsabilidade só, dados pelo construtor.

import 'package:material_ui/material_ui.dart';

class ProdutoCabecalho extends StatelessWidget {
  const ProdutoCabecalho({super.key, required this.nome, required this.preco});

  final String nome;
  final String preco;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nome,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          preco,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
