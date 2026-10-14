// 03_quebrar_em_widget.dart
// Demonstra: a alternativa ao Builder. O problema do exemplo 02 (precisar de um
//   context ABAIXO do Scaffold) também se resolve QUEBRANDO o build em outro widget.
// Novo em relação ao 02: sem Builder. Quando o corpo vira o seu próprio widget, o
//   build DELE já recebe um context que nasce dentro do Scaffold. É a mesma ideia —
//   um context abaixo do provedor — e costuma ficar mais limpo quando o trecho cresce.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppQuebrado());

class AppQuebrado extends StatelessWidget {
  const AppQuebrado({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TelaHost());
  }
}

class TelaHost extends StatelessWidget {
  const TelaHost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quebrar em widget')),
      drawer: const Drawer(),
      // O corpo virou um widget próprio: o build dele já nasce ABAIXO do Scaffold.
      body: const _ConteudoDaTela(),
    );
  }
}

class _ConteudoDaTela extends StatelessWidget {
  const _ConteudoDaTela();

  @override
  Widget build(BuildContext context) {
    // * Este é o context de _ConteudoDaTela, que está dentro do Scaffold. Scaffold.of
    // * sobe a partir daqui e acha — sem precisar de Builder.
    return Center(
      child: ElevatedButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        child: const Text('Abrir drawer (sem Builder)'),
      ),
    );
  }
}
