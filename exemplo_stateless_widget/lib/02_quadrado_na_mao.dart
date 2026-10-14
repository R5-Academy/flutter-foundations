// 02_quadrado_na_mao.dart
// Demonstra: criar um widget DO ZERO escrevendo o par Widget + Element na mão.
// Novo em relação ao 01: em vez de usar StatelessWidget, estendemos Widget "cru"
//   e escrevemos NÓS MESMOS o Element (um ComponentElement) que compõe a UI.
//
// IMPORTANTE: paramos no nível de WIDGET. O Element apenas COMPÕE outros widgets
//   (SizedBox, ColoredBox) — nada de RenderObject, canvas ou pixel. Quem pinta é
//   o ColoredBox, lá no fundo.
//
// Repare na cerimônia: duas classes só para dizer "componha um
// quadrado". No exemplo 03 isso vira uma classe só.
//
// Rode este arquivo: um quadrado azul de 120px aparece centralizado.

import 'package:flutter/widgets.dart';

void main() {
  runApp(
    const Center(child: QuadradoColorido(lado: 120, cor: Color(0xFF2196F3))),
  );
}

// =========================================================================
// 1) O WIDGET — só descrição imutável (campos final). Um Widget "cru" NÃO sabe
//    se construir: a ÚNICA coisa que ele faz é criar o SEU Element.
//    (É isso que StatelessWidget/StatefulWidget fazem por você automaticamente.)
// =========================================================================
class QuadradoColorido extends Widget {
  const QuadradoColorido({super.key, required this.lado, required this.cor});

  final double lado;
  final Color cor;

  // createElement: "qual Element me representa na árvore viva?"
  @override
  Element createElement() => _QuadradoColoridoElement(this);
}

// =========================================================================
// 2) O ELEMENT — o "quem" vivo que PERSISTE na árvore. É AQUI que mora o build().
//    ComponentElement é a família de Element que COMPÕE (não pinta). O build()
//    não recebe context porque o próprio Element JÁ É o BuildContext.
// =========================================================================
class _QuadradoColoridoElement extends ComponentElement {
  _QuadradoColoridoElement(QuadradoColorido super.widget);

  @override
  Widget build() {
    // O Element persiste, mas o framework atualiza 'widget' para a config atual
    // a cada rebuild. Por isso o "quem persiste" é o Element, não o widget.
    final quadrado = widget as QuadradoColorido;
    return SizedBox(
      width: quadrado.lado,
      height: quadrado.lado,
      child: ColoredBox(color: quadrado.cor), // a FOLHA que realmente pinta
    );
  }
}
