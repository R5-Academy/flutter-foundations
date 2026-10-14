# Assets prontos para a demo — Assets e Fontes

Pasta `assets/` pronta para **copiar inteira** para a raiz de um projeto Flutter
(ao lado do `pubspec.yaml`). Cobre todos os `exemplos/*.dart` da aula.

## O que tem aqui

```
assets/
├── images/
│   ├── logo.png          ← 1.0x (72px)   — usado em 01 e 02
│   ├── 2.0x/logo.png     ← 144px         — densidade (exemplo 02)
│   ├── 3.0x/logo.png     ← 216px         — densidade (exemplo 02)
│   ├── perfil.png        ← 240px         — usado no exercicio.md
│   ├── paisagem.jpg      ← 480x320       — imagem "solta" p/ demonstrar .jpg
│   └── icones/
│       └── mascote.png   ← 96px          — mostra que subpasta NÃO entra sozinha
├── data/
│   └── config.json       ← usado no exemplo 03 (rootBundle.loadString)
└── fonts/
    ├── Raleway-Regular.ttf   ← peso 400        — exemplo 04
    ├── Raleway-Italic.ttf    ← 400 itálico
    └── Raleway-Bold.ttf      ← peso 700
```

> Imagens: fotos de placeholder do [picsum.photos](https://picsum.photos)
> (convertidas para PNG real). As três `logo.png` são a **mesma** imagem em
> tamanhos crescentes, de propósito, para ilustrar a resolução por densidade.
> Fonte: **Raleway** ([OFL](https://openfontlicense.org)), instâncias estáticas
> geradas a partir da fonte variável do repositório `google/fonts`.

## `pubspec.yaml` que acompanha (cole dentro do bloco `flutter:`)

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/          # a pasta inteira (repare na barra final)
    - assets/images/icones/   # subpasta precisa de linha própria
    - assets/data/config.json

  fonts:
    - family: Raleway
      fonts:
        - asset: assets/fonts/Raleway-Regular.ttf
        - asset: assets/fonts/Raleway-Italic.ttf
          style: italic
        - asset: assets/fonts/Raleway-Bold.ttf
          weight: 700
```

Depois de mexer no `pubspec.yaml`, **re-rode** o app (`flutter run` / hot
restart) — hot reload não pega mudança de assets/fonts.
