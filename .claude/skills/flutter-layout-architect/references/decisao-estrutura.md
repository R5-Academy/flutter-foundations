# Decidir a estrutura da tela

Guia para desenhar a **árvore de widgets** no nível de tela/componente e para
levantar as alternativas que vão na proposta. A ideia central: **deixe o problema
visual escolher a estrutura**, e sempre encaixe primeiro os widgets reaproveitáveis
achados na varredura do projeto.

## Anatomia de uma tela (esqueleto padrão)

A maioria das telas cai neste molde — comece por ele e vá especializando:

```
Scaffold
├─ appBar: (AppBar | SliverAppBar dentro de CustomScrollView)
├─ body: <a estrutura do conteúdo>
├─ floatingActionButton / bottomNavigationBar / bottomSheet: (quando houver)
└─ (SafeArea onde o conteúdo encostar em notch/barras)
```

Decisões de esqueleto:

- **App bar fixa** → `AppBar` normal no `Scaffold`.
- **App bar que colapsa / imagem com parallax ao rolar** → `SliverAppBar` dentro
  de `CustomScrollView` (o body inteiro vira slivers).
- **Ação principal fixa embaixo** → `bottomNavigationBar` (o `Scaffold` cuida de
  safe area e insets do teclado) ou um widget fixo fora da área rolável.
- **Conteúdo que pode ficar sob teclado** → deixe o `Scaffold` redimensionar
  (`resizeToAvoidBottomInset`, o padrão) e/ou `SafeArea`.

## Rola ou não rola? (decisão que define a estrutura)

| Situação | Estrutura |
| --- | --- |
| Conteúdo cabe sempre na tela | `Column` (sem rolagem). |
| Conteúdo estático que *pode* estourar (form, detalhe) | `SingleChildScrollView` → `Column`. |
| Lista de itens repetidos, tamanho conhecido/pequeno | `ListView(children: [...])`. |
| Lista longa/dinâmica | `ListView.builder` (lazy). |
| Lista com separadores | `ListView.separated`. |
| Grade de itens | `GridView.builder` (+ `SliverGridDelegate`). |
| Parte fixa + parte rolável na mesma tela | `Column` com a parte rolável dentro de `Expanded` → (`SingleChildScrollView`/`ListView`). |
| Várias listas/seções heterogêneas rolando juntas, ou app bar colapsável | `CustomScrollView` + slivers (`SliverList`, `SliverGrid`, `SliverToBoxAdapter`, `SliverAppBar`). |

Erro comum a evitar: embrulhar um `ListView` (que já rola) em
`SingleChildScrollView`. E `Column` dentro de `SingleChildScrollView` com um
`Expanded` dentro estoura — dentro de scroll não há altura infinita para
`Expanded` dividir.

## Dividir espaço e arranjar filhos

| Preciso de… | Widget | Nota |
| --- | --- | --- |
| Filhos em linha / coluna | `Row` / `Column` | Estoura se somar mais que o eixo → `Expanded`/`Flexible`/`Wrap`. |
| Um filho ocupa o resto | `Expanded` | `flex:` divide proporcional entre vários. |
| Filho encolhe mas não é forçado a crescer | `Flexible(fit: loose)` | |
| Empurrar filhos pras pontas | `mainAxisAlignment: spaceBetween` | Antes de sair pondo `Spacer`. |
| Empurrar um filho pra ponta | `Spacer()` | Um `Expanded` vazio. |
| Espaço fixo entre widgets | `SizedBox` (ou `Gap` se o projeto usa) | Não use `Container` vazio. |
| Quebra de linha automática (chips/tags) | `Wrap` | |
| Sobreposição (badge sobre avatar, texto sobre imagem) | `Stack` + `Positioned`/`Align` | |

## Responsividade (quando o pedido menciona tablet/telas diferentes)

- **Breakpoint** (celular vs tablet/desktop) → `LayoutBuilder`
  (`constraints.maxWidth`) ou `MediaQuery`. Decida um limite (ex.: 600) e troque
  a estrutura: `Row` de painéis no largo, `Column` no estreito.
- **Proporção** dentro de uma linha/coluna → `Expanded(flex:)`.
- **Fração do pai** → `FractionallySizedBox(widthFactor:)`.
- **Grade que se adapta** → `GridView` com `SliverGridDelegateWithMaxCrossAxisExtent`
  (nº de colunas varia com a largura) em vez de `crossAxisCount` fixo.
- Se o projeto usa um pacote de responsividade (ver varredura), **siga a
  convenção dele**.

## Como decompor uma tela grande

1. Identifique as **seções visuais** (header, lista, rodapé de ação…).
2. Cada seção que se repete ou tem lógica visual própria vira um **widget
   extraído** (`_Header`, `_ProductInfo`, `_BuyBar`) — não um `build` gigante.
3. Prefira os **componentes do projeto** para as folhas (botões, cards, inputs).
4. Só então escolha os widgets de arranjo (`Column`/`Row`/scroll) que costuram as
   seções.

## Como gerar as alternativas da proposta

A proposta pede 1–2 alternativas com trade-off. Bons eixos para variar:

- **Rolagem:** `Column`+`SingleChildScrollView` **vs** `CustomScrollView`+slivers
  (slivers ganham quando há app bar colapsável ou muitas seções heterogêneas;
  perdem em simplicidade).
- **Esqueleto:** botão na `Column` **vs** `bottomNavigationBar`/`bottomSheet` do
  `Scaffold` (o Scaffold cuida de insets por você).
- **Componente:** widget nativo agora **vs** extrair um componente reaproveitável
  (quando o padrão vai se repetir no app).
- **Responsivo:** layout único **vs** dois layouts por breakpoint (só quando o
  pedido fala de tablet/desktop — não complique sem necessidade).
- **Arranjo:** `Stack` (sobreposição) **vs** `Column`/`Row` (fluxo) quando dá
  para resolver o visual dos dois jeitos.

Regra para a recomendação: **o mais simples que atende ao pedido**. Escale para
slivers, breakpoints e abstrações só quando o requisito justificar.
