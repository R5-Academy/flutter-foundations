// exemplo_02_deactivate_antes_do_dispose.dart
// Demonstra: quando o widget sai da arvore e NAO volta, a sequencia e sempre
//   deactivate() -> dispose(). O deactivate vem SEMPRE antes; o dispose e a
//   saida definitiva (o "nunca mais vou construir"). O dispose e o tema da
//   PROXIMA aula: aqui so mostramos que ele fecha a fila logo depois do deactivate.
// Novo em relacao ao 01: adiciona o dispose com log para enxergar a ordem.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaPai()));

class TelaPai extends StatefulWidget {
  const TelaPai({super.key});

  @override
  State<TelaPai> createState() => _TelaPaiState();
}

class _TelaPaiState extends State<TelaPai> {
  bool _mostrar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('deactivate antes do dispose')),
      body: Center(
        child: _mostrar
            ? const BlocoEfemero()
            : const Text('Bloco removido (veja o console)'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => _mostrar = !_mostrar),
        label: Text(_mostrar ? 'Remover de vez' : 'Trazer de volta'),
        icon: const Icon(Icons.delete_outline),
      ),
    );
  }
}

class BlocoEfemero extends StatefulWidget {
  const BlocoEfemero({super.key});

  @override
  State<BlocoEfemero> createState() => _BlocoEfemeroState();
}

class _BlocoEfemeroState extends State<BlocoEfemero> {
  @override
  void deactivate() {
    // Passo 1: saiu da arvore. Ainda NAO se sabe se e adeus ou reinsercao.
    debugPrint('1) deactivate() -> saiu da arvore');
    super.deactivate();
  }

  // * dispose e a proxima aula. Aqui so provamos que, quando ninguem reinsere o
  //   widget ate o fim do frame, o dispose vem logo depois do deactivate.
  @override
  void dispose() {
    // Passo 2: ninguem reinseriu no frame -> saida definitiva.
    debugPrint('2) dispose() -> nao voltou no frame, destruido de vez');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.orange.shade100,
      child: const Text('Some ao remover'),
    );
  }
}
