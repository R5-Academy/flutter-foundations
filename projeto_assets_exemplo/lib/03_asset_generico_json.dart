// 03_asset_generico_json.dart
// Demonstra: asset NÃO é só imagem. Um .json, .txt, .csv também é asset — e a
// gente lê como DADOS, através de um AssetBundle.
// Novo em relação aos anteriores: carregar o conteúdo de um arquivo com
// rootBundle.loadString / DefaultAssetBundle.of(context).
//
// PASSO 1 — crie o arquivo:  assets/data/config.json
//   { "titulo": "Academia do Flutter" }
//
// PASSO 2 — declare no pubspec.yaml:
//
//   flutter:
//     assets:
//       - assets/data/config.json

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<void> main() async {
  // Vamos usar o rootBundle ANTES do runApp; para isso é preciso inicializar o
  // binding do Flutter primeiro (senão dá erro de "binding not initialized").
  WidgetsFlutterBinding.ensureInitialized();

  // rootBundle: o "cofre" global de assets do app. Use quando você NÃO tem um
  // BuildContext à mão (aqui, no main). loadString lê o arquivo como texto.
  final String conteudo = await rootBundle.loadString(
    'assets/data/config.json',
  );
  print('Conteúdo do JSON: $conteudo');

  runApp(const MaterialApp(home: Text('Veja o config no console')));
}

// Dentro de um widget, quando você TEM um BuildContext, a doc recomenda:
//
//   DefaultAssetBundle.of(context).loadString('assets/data/config.json')
//
// Ele usa o bundle "em vigor" na árvore (útil em testes) e, se não houver,
// cai automaticamente no rootBundle. Ambos leem os MESMOS assets declarados.
//
// Para bytes crus (arquivos binários) existe rootBundle.load(...), que devolve
// um ByteData.
