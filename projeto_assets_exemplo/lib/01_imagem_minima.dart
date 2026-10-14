// 01_imagem_minima.dart
// Demonstra: o "olá mundo" de assets — declarar UMA imagem no pubspec e
// exibi-la com Image.asset.
// A regra de ouro: colocar o arquivo na pasta NÃO basta; ele só existe pro app
// se estiver declarado no pubspec.yaml.
//
// PASSO 1 — coloque a imagem em:  assets/images/logo.png
//
// PASSO 2 — declare no pubspec.yaml (repare na indentação de 2 espaços!):
//
//   flutter:
//     uses-material-design: true
//     assets:
//       - assets/images/logo.png
//
// PASSO 3 — RE-RODE o app (flutter run). Hot reload NÃO pega mudança no
// pubspec.yaml; é preciso hot restart / rodar de novo.

import 'package:material_ui/material_ui.dart';

void main() {
  // home aceita qualquer widget. Como Image.asset JÁ é um widget, ele pode ir
  // direto no home — sem precisar de tela/layout ainda (isso vem nas próximas
  // fases). Aqui só provamos que a imagem carregou.
  runApp(MaterialApp(home: Image.asset('assets/images/logo.png')));
}

// Observação: as duas formas abaixo são equivalentes.
//   Image.asset('assets/images/logo.png')
//   Image(image: AssetImage('assets/images/logo.png'))
// Use Image.asset(...) no dia a dia. O AssetImage aparece quando outro widget
// pede um ImageProvider (ex.: CircleAvatar(backgroundImage: ...)) — mas isso
// já é estilização, assunto de Flutter UI Development.
