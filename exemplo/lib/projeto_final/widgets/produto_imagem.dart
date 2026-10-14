// produto_imagem.dart
// A área da imagem do produto. Recebe o ícone pelo construtor.

import 'package:material_ui/material_ui.dart';

class ProdutoImagem extends StatelessWidget {
  const ProdutoImagem({super.key, required this.icone});

  final IconData icone;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFECEFF1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icone, size: 96, color: Colors.blueGrey),
    );
  }
}
