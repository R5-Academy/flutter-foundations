// 04_reassemble.dart
// Demonstra: reassemble como a saida para o problema do exemplo 03. Se um dado e
//   preparado no initState (e por isso nao atualiza no Hot Reload), voce pode
//   refazer essa preparacao dentro do reassemble, que roda a CADA Hot Reload.
// Novo em relacao ao 03: em vez de exigir Hot Restart, o reassemble faz o valor
//   derivado acompanhar o reload durante o desenvolvimento.
// Passo a passo:
//   1. Rode: a lista aparece formatada em MAIUSCULAS.
//   2. Troque .toUpperCase() por .toLowerCase() em _prepararResumo e salve
//      (Hot Reload) -> a tela ATUALIZA, mesmo o dado vindo do initState.
//      Por que? reassemble chamou _prepararResumo de novo.
//   3. Comente a linha do reassemble e repita: agora o Hot Reload NAO reflete
//      (volta a exigir Restart). Isso prova o papel do reassemble.
// Este e o uso canonico da doc: "rerun any initialization logic that depends on
// global state" (o proprio Image usa reassemble para recarregar assets).

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaResumo()));

// Faz de conta que estes vieram de uma fonte externa (config, asset, API).
const _produtos = ['Notebook', 'Mouse', 'Teclado'];

class TelaResumo extends StatefulWidget {
  const TelaResumo({super.key});

  @override
  State<TelaResumo> createState() => _TelaResumoState();
}

class _TelaResumoState extends State<TelaResumo> {
  late String _resumo;

  // A preparacao do dado fica isolada num metodo, para ser chamada dos dois
  // lugares: na criacao (initState) e a cada Hot Reload (reassemble).
  String _prepararResumo() {
    return _produtos.map((p) => p.toUpperCase()).join(' | ');
  }

  @override
  void initState() {
    super.initState();
    _resumo = _prepararResumo();
  }

  @override
  void reassemble() {
    super.reassemble();
    // * Sem esta linha, mexer em _prepararResumo so apareceria depois de um Hot
    //   Restart. Com ela, o Hot Reload ja mostra o resultado novo.
    _resumo = _prepararResumo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('reassemble no Hot Reload')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(_resumo, style: Theme.of(context).textTheme.titleLarge),
        ),
      ),
    );
  }
}
