# Versão do Flutter e checagem de API atual

Propor um widget ou campo que não existe (ou está deprecated) na versão do
projeto quebra o build ou gera aviso. Descubra a versão **do projeto atual** e
confirme a API por ela.

## 1. Descobrir a versão configurada

Procure nesta ordem — a primeira fonte confiável vence:

1. **`fvm` (Flutter Version Management)** — se houver `.fvmrc` ou
   `.fvm/fvm_config.json` na raiz, a versão fixada está ali (campo
   `flutterSdkVersion`/`flutter`). Projetos com fvm costumam pinar a versão
   exata — é a fonte mais precisa.
2. **`pubspec.yaml`** — a seção `environment` traz as *constraints*:
   ```yaml
   environment:
     sdk: ">=3.5.0 <4.0.0"      # versão do Dart
     flutter: ">=3.24.0"         # versão mínima do Flutter (nem sempre presente)
   ```
   A constraint do `sdk` (Dart) ajuda a inferir a faixa do Flutter (ver mapa
   abaixo). É um piso, não a versão exata instalada.
3. **`flutter --version`** — se der para rodar no ambiente, mostra a versão
   realmente instalada (Flutter + Dart + canal). Use quando pubspec/fvm forem
   ambíguos. Com fvm: `fvm flutter --version`.
4. **`pubspec.lock`** — o campo `sdks:` (Dart) e as versões resolvidas dos
   pacotes dão pistas adicionais.

Se as fontes divergirem, prefira a **mais restritiva/exata** (fvm > constraint do
pubspec) e, na dúvida, diga na resposta qual versão você assumiu.

### Mapa rápido Dart SDK → Flutter (aproximado)

Para inferir o Flutter quando só há a constraint do Dart:

| Dart SDK | Flutter (aprox.) |
| --- | --- |
| `>=3.9` | 3.35+ |
| `>=3.5` | 3.24+ |
| `>=3.4` | 3.22+ |
| `>=3.3` | 3.19+ |
| `>=3.0` | 3.10+ |

Não precisa de precisão cirúrgica — serve para saber "estamos em Flutter 3.2x/3.3x"
e decidir se uma API recente já existe ou se uma antiga já foi removida.

## 2. Confirmar a API pela documentação da versão

Para widgets triviais e estáveis (`Container`, `Row`, `Column`, `Padding`,
`SizedBox`, `Center`, `Stack`) você já conhece a API — não precisa consultar.

Consulte quando a API **muda entre versões** ou você está inseguro. Use o
**`context7`**:

1. `resolve-library-id` com "Flutter" para obter o id da lib.
2. `query-docs` perguntando pelo widget/campo **e citando a versão** do projeto
   (ex.: "No Flutter 3.24, quais os parâmetros atuais de `CardTheme`? `color` e
   `shape` seguem válidos ou migraram para `CardThemeData`?").

Se `context7` não resolver, use a doc oficial da API
(`api.flutter.dev`) via web, sempre mirando a versão do projeto.

## 3. Deprecations comuns — cheque estas quando aparecerem

Estes são os pontos que mais mudam e onde propor o antigo gera aviso/erro.
Confirme na versão do projeto antes de usar:

- **`Color.withOpacity(x)`** → deprecated em favor de **`.withValues(alpha: x)`**
  (Flutter 3.27+). Em versões antigas, `withOpacity` ainda é o certo.
- **`MaterialState*`** → renomeado para **`WidgetState*`**
  (`MaterialStateProperty` → `WidgetStateProperty`, `MaterialStatesController` →
  `WidgetStatesController`) a partir do 3.19; o alias antigo foi ficando
  deprecated.
- **`CardTheme` / `DialogTheme` / `TabBarTheme`** (a instância) → migraram para
  **`CardThemeData` / `DialogThemeData` / `TabBarThemeData`** em `ThemeData`.
- **`ButtonBar`** → removido; use `OverflowBar` ou uma `Row`/`Wrap` de botões.
- **`RaisedButton` / `FlatButton` / `OutlineButton`** → há tempos substituídos
  por **`ElevatedButton` / `TextButton` / `OutlinedButton`** (e `FilledButton`).
- **`Scaffold.resizeToAvoidBottomPadding`** → `resizeToAvoidBottomInset`.
- **`textScaleFactor`** (em `MediaQuery`/`Text`) → **`TextScaler`**
  (`MediaQuery.textScalerOf(context)`).
- **`WillPopScope`** → **`PopScope`** (a partir do 3.12/3.16).

A lista não é exaustiva e o que está "deprecated" depende da versão — por isso a
regra é: **na dúvida, confirme na versão do projeto**, não confie na memória.

## Como reportar na resposta

Quando a versão influenciar a proposta, deixe explícito: "Assumi Flutter 3.24
(pelo `environment.sdk` do pubspec). Por isso usei `.withValues(alpha:)` no lugar
de `withOpacity`." Isso deixa a LLM que chamou ajustar se a versão real for
outra.
