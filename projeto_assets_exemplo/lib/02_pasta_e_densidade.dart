// 02_pasta_e_densidade.dart
// Demonstra: declarar uma PASTA inteira de uma vez e como o Flutter escolhe a
// imagem certa por densidade de tela (2.0x/, 3.0x/).
// Novo em relação ao 01: em vez de listar arquivo por arquivo, declaramos a
// pasta; e organizamos variantes de resolução.
//
// ESTRUTURA DE PASTAS:
//
//   assets/
//   └── images/
//       ├── logo.png        <- 1.0x (base)   ex.: 72x72
//       ├── 2.0x/
//       │   └── logo.png     <- 2.0x          ex.: 144x144
//       └── 3.0x/
//           └── logo.png     <- 3.0x          ex.: 216x216
//
// DECLARAÇÃO no pubspec.yaml — você declara SÓ o arquivo base (ou a pasta):
//
//   flutter:
//     assets:
//       - assets/images/          # <- a BARRA no final é obrigatória p/ pasta!
//
//   As variantes 2.0x/ e 3.0x/ entram sozinhas — NÃO liste elas.
//   Atenção: declarar a pasta inclui só os arquivos diretamente dentro dela,
//   NÃO entra em subpastas suas recursivamente (exceto as Nx/ de densidade).

import 'package:material_ui/material_ui.dart';

void main() {
  // No código você também referencia SÓ o caminho base. Em runtime o Flutter
  // olha o devicePixelRatio do aparelho e escolhe a variante mais nítida
  // (2.7 -> usa 3.0x/; 1.8 -> usa 2.0x/). O tamanho lógico na tela é o mesmo.
  runApp(MaterialApp(home: Image.asset('assets/images/logo.png')));
}
