// secao_avaliacoes.dart
// O título "Avaliações" + a lista de avaliações. Compõe vários ItemAvaliacao.
// (Aqui as avaliações estão fixas para o exemplo; num app de verdade viriam de
// uma lista de dados. Isso a gente vê nas próximas fases.)

import 'package:flutter/material.dart';

import 'item_avaliacao.dart';

class SecaoAvaliacoes extends StatelessWidget {
  const SecaoAvaliacoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Avaliações',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ItemAvaliacao(
            nome: 'Ana Souza', comentario: 'Melhor fone que já tive. Bateria dura muito!'),
        ItemAvaliacao(
            nome: 'Bruno Lima', comentario: 'Cancelamento de ruído excelente.'),
        ItemAvaliacao(
            nome: 'Carla Dias', comentario: 'Bom custo-benefício, recomendo.'),
      ],
    );
  }
}
