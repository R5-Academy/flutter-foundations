// 04_fonte_customizada.dart
// Demonstra: empacotar uma FONTE customizada no app e usá-la via fontFamily.
// Novo: o bloco flutter: fonts: do pubspec, com family / asset / weight / style.
//
// PASSO 1 — baixe a fonte (ex.: Raleway no https://fonts.google.com) e coloque
// os .ttf em:  assets/fonts/
//
// PASSO 2 — declare no pubspec.yaml (dentro de flutter:, 2 espaços):
//
//   flutter:
//     fonts:
//       - family: Raleway
//         fonts:
//           - asset: assets/fonts/Raleway-Regular.ttf
//           - asset: assets/fonts/Raleway-Italic.ttf
//             style: italic
//           - asset: assets/fonts/Raleway-Bold.ttf
//             weight: 700
//
//   - family: o nome que VOCÊ inventa e vai usar no código (a string do fontFamily).
//   - asset:  caminho do arquivo .ttf/.otf.
//   - weight: número de 100 a 900 (400=regular, 700=bold). Opcional.
//   - style:  normal | italic. Opcional.
//
// PASSO 3 — RE-RODE o app (mexeu no pubspec, hot reload não pega).

import 'package:material_ui/material_ui.dart';

void main() {
  // Depois de declarada, a fonte é referenciada pelo NOME da família.
  // Exemplo MÍNIMO só para provar que a fonte carregou — estilizar texto de
  // verdade (tamanho, cor, layout) é assunto de Flutter UI Development.
  runApp(
    const MaterialApp(
      home: Text('Olá com Raleway', style: TextStyle(fontFamily: 'Raleway')),
    ),
  );
}

// Para pedir o negrito, use fontWeight JUNTO com a família — e só funciona bem
// se você declarou o arquivo daquele peso (o weight: 700 do YAML):
//
//   Text('Negrito', style: TextStyle(
//     fontFamily: 'Raleway',
//     fontWeight: FontWeight.w700, // casa com o weight: 700 declarado
//   ))
//
// Cuidado: no pubspec o peso é NÚMERO (weight: 700); no Dart é objeto
// (FontWeight.w700, ou o atalho FontWeight.bold). E FontWeight.bold não "cria"
// negrito: ele SELECIONA o arquivo bold que você declarou. Sem esse arquivo, o
// Flutter engrossa a fonte artificialmente e o resultado fica feio.
//
// Alternativa a empacotar: o pacote google_fonts baixa a fonte em runtime e
// guarda em cache — evita inchar o app. Mencionado só como opção.
