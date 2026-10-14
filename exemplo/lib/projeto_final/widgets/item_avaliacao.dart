// item_avaliacao.dart
// UMA avaliação: avatar + nome + comentário. Peça parametrizada, usada em
// secao_avaliacoes.dart.

import 'package:material_ui/material_ui.dart';

class ItemAvaliacao extends StatelessWidget {
  const ItemAvaliacao({
    super.key,
    required this.nome,
    required this.comentario,
  });

  final String nome;
  final String comentario;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(child: Icon(Icons.person)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(comentario),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
