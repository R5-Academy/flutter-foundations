// produto_descricao.dart
// O título "Descrição" + o texto. Recebe o texto pelo construtor.

import 'package:material_ui/material_ui.dart';

class ProdutoDescricao extends StatelessWidget {
  const ProdutoDescricao({super.key, required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descrição',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(texto),
      ],
    );
  }
}
