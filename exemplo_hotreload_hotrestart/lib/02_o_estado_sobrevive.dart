// 02_o_estado_sobrevive.dart
// Demonstra: por que o Hot Reload "mantem o estado". O objeto State e o MESMO
//   antes e depois do reload; so o build roda de novo. Entao o contador nao
//   zera, mas a mudanca visual aparece.
// Novo em relacao ao 01: sai do log e mostra o efeito na tela.
// Passo a passo:
//   1. Suba o contador ate, digamos, 7.
//   2. Troque Colors.indigo por Colors.red abaixo e salve (Hot Reload).
//      -> o numero CONTINUA 7, so muda a cor. O State sobreviveu.
//   3. De um Hot Restart (R) -> o numero VOLTA a 0. State novo, do zero.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: Contador()));

class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int _cliques = 0; // o estado: vive no objeto State, sobrevive ao Hot Reload

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O estado sobrevive')),
      body: Center(
        child: Text(
          '$_cliques',
          // Troque a cor aqui e de Hot Reload: o numero fica, a cor muda.
          style: const TextStyle(color: Colors.indigo, fontSize: 96),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _cliques++),
        child: const Icon(Icons.add),
      ),
    );
  }
}
