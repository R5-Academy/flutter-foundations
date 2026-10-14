// 03_o_mesmo_quadrado_atalho.dart
// Demonstra: o MESMO quadrado do exemplo 02 — agora sem escrever o Element.
// Novo em relação ao 02: some a classe _QuadradoColoridoElement inteira. O
//   StatelessWidget cria o Element por você (um StatelessElement) e ainda traz o
//   build() para DENTRO do widget, com o context na mão. Duas classes viram uma.
//
// Momento-chave da aula: o alívio. Mesma saída na tela, metade da cerimônia.
//
// E continua sendo COMPOSIÇÃO: o build só arranja SizedBox + ColoredBox. Quem
// pinta é o ColoredBox, exatamente como no 02. Você não desceu de nível — só
// parou de reescrever o Element toda vez.

import 'package:flutter/widgets.dart';

void main() {
  runApp(
    const Center(child: QuadradoColorido(lado: 120, cor: Color(0xFF2196F3))),
  );
}

// Uma classe só. Sem createElement na mão, sem classe Element. O StatelessWidget
// já responde ao createElement() (devolvendo um StatelessElement) por baixo.
class QuadradoColorido extends StatelessWidget {
  const QuadradoColorido({super.key, required this.lado, required this.cor});

  final double lado;
  final Color cor;

  // O build() que no exemplo 02 morava no Element agora mora AQUI. Aquele
  // 'context' é o próprio StatelessElement se passando — o mesmo Element que
  // você escreveu na mão antes, só que agora o Flutter o escreveu por você.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: lado,
      height: lado,
      child: ColoredBox(color: cor),
    );
  }
}
