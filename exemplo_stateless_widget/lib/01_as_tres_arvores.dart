// 01_as_tres_arvores.dart
// Demonstra: o mapa mental da aula, em comentário — as árvores que trabalham
//            juntas por baixo de QUALQUER app Flutter.
// Ponto de partida: relembrar "Tudo é Widget" antes de escrever um widget na mão.
//
// Este arquivo roda com widgets já conhecidos. Ele é a âncora: o que aparece na
// tela passa pela mesma dupla Widget + Element que vamos escrever no exemplo 02.

import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// AS TRÊS ÁRVORES (o conceito da aula):
//
//   Widget        -> a DESCRIÇÃO da UI. Imutável, barata, recriada a cada build.
//                    É a "planta da casa" no papel. Só descreve; não sabe se montar.
//
//   Element       -> o "QUEM" vivo na árvore. PERSISTE entre rebuilds. É ele que
//                    tem o build() e COMPÕE os widgets filhos.
//                    É o "engenheiro da obra". Nesta aula vamos escrevê-lo na mão.
//
//   RenderObject  -> quem mede e PINTA os pixels, lá no fundo, nas folhas.
//                    NÃO mexemos nele nesta aula (isso é Flutter Advanced).
//                    Só apontamos: é ele que pinta o ColoredBox/Text.
//
// Frase de bolso: "Widget descreve. Element persiste e compõe. RenderObject pinta."
//
// A chave da aula: um widget de COMPOSIÇÃO (como o que faremos, e como o próprio
// StatelessWidget) NÃO pinta — ele só descreve outros widgets. Quem pinta são as
// folhas (Text, ColoredBox), e são elas que têm RenderObject.
// ---------------------------------------------------------------------------

void main() {
  runApp(
    const Center(
      // Este Text é uma FOLHA: lá no fundo ele tem um RenderObject que pinta.
      // Nós NÃO vamos escrever esse nível — vamos parar no Widget + Element.
      child: Text(
        'Widget descreve, Element compõe.',
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}
