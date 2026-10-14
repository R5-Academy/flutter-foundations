// 05_armadilhas.dart
// Demonstra: os erros clássicos de assets/fontes — o "errado" e o "certo" lado
// a lado. O objetivo é você RECONHECER o erro quando ele acontecer.
// Este arquivo é um catálogo comentado; rode a versão CERTA no fim.

import 'package:material_ui/material_ui.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ARMADILHA 1 — INDENTAÇÃO DO YAML (o erro nº 1)
// assets:/fonts: precisam estar DENTRO de flutter: (2 espaços). YAML não aceita
// tab, só espaços. Sintoma: "Error: unable to find directory entry in pubspec".
//
//   # ERRADO — assets fora de flutter:
//   flutter:
//     uses-material-design: true
//   assets:                       # <- nível errado! não é filho de flutter:
//     - assets/images/logo.png
//
//   # CERTO
//   flutter:
//     uses-material-design: true
//     assets:                     # <- 2 espaços, dentro de flutter:
//       - assets/images/logo.png
//
// ─────────────────────────────────────────────────────────────────────────────
// ARMADILHA 2 — MEXEU NO pubspec.yaml? RE-RODE O APP.
// Hot reload (⚡) NÃO pega mudança de assets/fontes. Faça hot restart ou rode
// de novo (flutter run). Regra de bolso: mexeu no pubspec, para e roda de novo.
//
// ─────────────────────────────────────────────────────────────────────────────
// ARMADILHA 3 — CAMINHO É CASE-SENSITIVE
//   Image.asset('assets/images/Logo.PNG')   // ERRADO se o arquivo é logo.png
//   Image.asset('assets/images/logo.png')   // CERTO
// "Funciona" no Mac/Windows e QUEBRA no device (Android/iOS). Confira nome,
// pasta e extensão, letra por letra.
//
// ─────────────────────────────────────────────────────────────────────────────
// ARMADILHA 4 — PASTA SEM A BARRA FINAL
//   flutter:
//     assets:
//       - assets/images     # ERRADO: interpretado como um ARQUIVO 'images'
//       - assets/images/    # CERTO: a barra final indica que é uma PASTA
//
// ─────────────────────────────────────────────────────────────────────────────
// ARMADILHA 5 — weight (YAML) x FontWeight (Dart)
//   No pubspec:  weight: 700         (número puro, 100..900 — 'bold' é INVÁLIDO)
//   No Dart:     FontWeight.w700     (ou FontWeight.bold, que é o mesmo w700)
//
// ─────────────────────────────────────────────────────────────────────────────
// ARMADILHA 6 (bônus) — SVG NÃO é nativo
//   Image.asset('assets/images/logo.svg')  // NÃO funciona
// SVG precisa do pacote flutter_svg:  SvgPicture.asset('assets/images/logo.svg')

void main() {
  // A forma CERTA, juntando o que a aula ensinou: caminho exato, minúsculas,
  // asset declarado no pubspec (com indentação correta) e app re-rodado.
  runApp(MaterialApp(home: Image.asset('assets/images/logo.png')));
}
