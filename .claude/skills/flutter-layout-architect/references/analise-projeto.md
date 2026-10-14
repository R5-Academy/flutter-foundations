# Varredura do projeto — o que reaproveitar

Rode esta varredura **no início de toda chamada**, antes de desenhar a estrutura.
O objetivo é descobrir o que o projeto **já padronizou** para não remontar do
zero. Nada aqui é fixo — o resultado muda a cada projeto. Trabalhe sobre o `lib/`
atual (ou a raiz de código que o projeto usar).

## O que procurar (por ordem de valor)

1. **Widgets customizados reaproveitáveis** — botões, cards, inputs, app bars,
   avatares, chips, seções, "empty states", loaders visuais. São o que mais
   evita retrabalho e mantém o app coerente.
2. **Design system / tokens** — cores (`AppColors`), espaçamentos (`AppSpacing`,
   `Insets`, `Gaps`), raios, tipografia (`AppTextStyles`), `ThemeExtension`.
3. **Tema** — `ThemeData`, `ColorScheme`, `TextTheme`, temas de componentes
   (`CardTheme`/`CardThemeData`, `ElevatedButtonTheme`…). Diz o que já vem
   estilizado "de graça" via `Theme.of(context)`.
4. **Convenções** — organização de pastas, nomes de arquivo (`snake_case`),
   sufixos (`_page`, `_view`, `_widget`), se usam `part`, se widgets ficam em
   `widgets/`/`components/`/`ui/`/`shared/`/`design_system/`/`core/`.

## Onde olhar (glob)

Pastas que costumam concentrar o reaproveitável:

```
lib/**/{widgets,components,ui,shared,common,design_system,core,theme,styles}/**/*.dart
lib/**/*_widget.dart
lib/**/*_button.dart
lib/**/*_card.dart
lib/theme*/**/*.dart
```

Também vale um mapa geral da estrutura para entender a convenção:

```
lib/**/*.dart        # visão geral de pastas e nomes
pubspec.yaml         # nome do pacote, dependências de UI (ver abaixo)
```

## Como caçar (grep)

Widgets customizados (classes de UI declaradas no projeto):

```
class\s+\w+\s+extends\s+(StatelessWidget|StatefulWidget|HookWidget|HookConsumerWidget|ConsumerWidget)
```

Design tokens / helpers de estilo:

```
class\s+App(Colors|Spacing|Sizes|Radius|TextStyles|Theme|Insets|Gaps)
abstract\s+(class|final class)\s+\w*(Colors|Spacing|Theme|Tokens)
extension\s+\w+\s+on\s+ThemeData     # ThemeExtension custom
```

Uso de tema já no código (mostra se o projeto é "theme-first"):

```
Theme\.of\(context\)\.(colorScheme|textTheme)
\.extension<\w+>\(\)
```

## Pistas no pubspec.yaml

Dependências de UI mudam o vocabulário de widgets que vale propor. Cheque a
seção `dependencies` por, entre outros:

- `flutter_screenutil`, `responsive_framework`, `flutter_bootstrap` →
  responsividade tem convenção própria; siga-a.
- `gap` → use `Gap(…)` em vez de `SizedBox` para espaço.
- `flutter_svg`, `cached_network_image` → como o projeto carrega imagens/ícones.
- `google_fonts` → tipografia vem daqui.
- design systems próprios ou de terceiros (ex.: `flutter_widgetkit`, pacotes
  internos) → prefira os componentes deles.

## Como usar o que achou

- **Achou um componente que serve** → use-o na estrutura e cite o caminho
  (`lib/ui/widgets/app_button.dart`). Confira a API real do componente (parâmetros
  que ele aceita) antes de passar props.
- **Achou tokens/tema** → puxe cores, espaços e tipografia de lá, não crave
  valores.
- **Achou uma convenção** (pastas, nomes, `part`) → siga-a no código que propor.
- **Não achou nada reaproveitável** (projeto novo/vazio) → registre isso na
  resposta e siga com widgets nativos, sugerindo (sem impor) extrair um
  componente quando o padrão se repetir.

Regra de ouro: **o projeto manda**. Uma proposta que ignora o `AppButton`
existente e reinventa um botão está errada, mesmo que o código compile.
