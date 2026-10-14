// botao_adicionar_carrinho.dart
// O botão de ação de largura total. O construtor pode ser `const` mesmo com o
// onPressed dentro — a função é criada no build, não é um campo do widget.

import 'package:flutter/material.dart';

class BotaoAdicionarCarrinho extends StatelessWidget {
  const BotaoAdicionarCarrinho({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Text('Adicionar ao carrinho'),
        ),
      ),
    );
  }
}
