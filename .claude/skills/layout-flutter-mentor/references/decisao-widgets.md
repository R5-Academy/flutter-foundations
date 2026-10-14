# Guia de decisão — qual widget para qual necessidade

Consulte quando estiver na dúvida entre dois widgets parecidos. A ideia é
sempre a mesma: **deixe o problema visual escolher o widget**, não o contrário.

## Estrutura: dispor filhos em linha, coluna ou pilha

| Preciso de... | Widget | Observação |
| --- | --- | --- |
| Filhos lado a lado (horizontal) | `Row` | Estoura se a soma passar da largura → use `Expanded`/`Flexible` ou `Wrap`. |
| Filhos empilhados (vertical) | `Column` | Mesma lógica do `Row` no eixo vertical. |
| Um sobre o outro (sobreposição) | `Stack` + `Positioned` | Badge sobre avatar, texto sobre imagem. |
| Quebra de linha automática | `Wrap` | Chips/tags que passam pra próxima linha quando não cabem. |
| Direção que muda por variável | `Flex(direction: ...)` | `Row`/`Column` são `Flex` com direção fixa. |

## Dividir espaço dentro de Row/Column

| Preciso de... | Widget | Diferença-chave |
| --- | --- | --- |
| Filho ocupa todo o espaço sobrando | `Expanded` | Força o filho a preencher. `flex:` divide proporcional entre vários. |
| Filho pode encolher, mas não é forçado a crescer | `Flexible(fit: FlexFit.loose)` | Ocupa só o que precisa, até o limite disponível. |
| Espaço fixo entre widgets | `SizedBox(width/height:)` | Mais barato e claro que `Container` vazio. |
| Empurrar filhos pras pontas | `mainAxisAlignment: spaceBetween` | Antes de sair pondo `Spacer`. |
| Empurrar um único filho pra ponta | `Spacer()` | Um `Expanded` vazio; bom pra "joga esse à direita". |

Regra prática: **Expanded** = "cresce e preenche"; **Flexible** = "pode encolher";
**SizedBox** = "espaço fixo e conhecido".

## Caixa, decoração e espaçamento

| Preciso de... | Widget | Observação |
| --- | --- | --- |
| Fundo + borda + cantos arredondados + padding, tudo junto | `Container(decoration: BoxDecoration(...))` | O canivete suíço. Não use `color:` e `decoration:` juntos. |
| Só decoração, sem padding | `DecoratedBox` | Mais leve que `Container` quando é só o visual. |
| Só espaço interno | `Padding` | Se já tem `Container`, use o `padding:` dele em vez de aninhar. |
| Recortar filho (imagem) em cantos arredondados | `ClipRRect(borderRadius: ...)` | `decoration` arredonda o fundo; `ClipRRect` recorta o conteúdo. |
| Sombra/elevação do Material de graça | `Card` | Já vem com elevação, cor de superfície e cantos. |
| Tamanho fixo sem decoração | `SizedBox(width:, height:)` | Não use `Container` só pra dar tamanho. |

## Alinhamento e posição

| Preciso de... | Widget |
| --- | --- |
| Centralizar um filho | `Center` (ou `Align(alignment: Alignment.center)`) |
| Alinhar num canto/borda | `Align(alignment: ...)` |
| Espaço interno | `Padding` |
| Espaço externo (margem) | `Container(margin:)` ou um `Padding` no pai |

## Listas e grades

| Preciso de... | Widget | Observação |
| --- | --- | --- |
| Lista rolável de tamanho conhecido/pequeno | `ListView(children: [...])` | Simples, mas constrói todos os filhos de uma vez. |
| Lista longa/dinâmica | `ListView.builder` | Constrói sob demanda (lazy) — use pra dados de tamanho variável. |
| Separadores entre itens | `ListView.separated` | Divisórias sem gambiarra. |
| Grade de itens | `GridView.builder` + `SliverGridDelegate...` | `crossAxisCount` fixo ou `maxCrossAxisExtent` responsivo. |
| Poucos itens em coluna, sem rolagem | `Column` | Não use `ListView` se não precisa rolar. |
| Rolagem de conteúdo estático que pode estourar | `SingleChildScrollView` | Só quando não é uma lista de itens repetidos. |

## Responsividade (adaptar a telas diferentes)

| Preciso de... | Widget | Observação |
| --- | --- | --- |
| Layout muda conforme o espaço disponível | `LayoutBuilder` | Dá as `constraints` do pai; decida com `constraints.maxWidth`. |
| Dado da tela/dispositivo (tamanho, orientação, textScale) | `MediaQuery.of(context)` | Use pra breakpoints globais e safe areas. |
| Filho ocupa uma fração do pai | `FractionallySizedBox(widthFactor: 0.5)` | "Metade da largura" sem calcular pixel. |
| Respeitar notch/barra de status | `SafeArea` | Envolve o conteúdo pra não ficar sob a barra. |
| Espaço proporcional dentro de Flex | `Expanded(flex: 2)` vs `Expanded(flex: 1)` | Proporção 2:1 sem números fixos. |

Regra: para **breakpoints** (celular vs tablet) pense `LayoutBuilder`/`MediaQuery`;
para **proporção** dentro de uma linha/coluna pense `Expanded flex`.

## Material vs Cupertino

- Padrão do curso e da maioria dos apps: **Material** (`Scaffold`, `AppBar`,
  `Card`, `ElevatedButton`, `TextField`).
- Use **Cupertino** (`CupertinoPageScaffold`, `CupertinoButton`,
  `CupertinoNavigationBar`) quando a pessoa pede visual iOS explicitamente ou o
  print é claramente iOS. Se o app é multiplataforma, mencione que dá pra
  adaptar por plataforma, mas não complique se não pediram.
