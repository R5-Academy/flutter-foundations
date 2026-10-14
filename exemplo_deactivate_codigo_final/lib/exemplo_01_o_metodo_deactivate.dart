// exemplo_01_o_metodo_deactivate.dart
// Demonstra: deactivate e chamado quando o State e REMOVIDO da arvore, e NAO a
//   cada rebuild. Um bloco vive dentro de um if(mostrar); um botao so reconstroi
//   (setState) e nada dispara deactivate; outro botao remove o bloco da arvore e
//   ai sim deactivate roda. Tambem mostra a assinatura com super por ULTIMO.
// Ponto de partida da secao "saida de cena" do ciclo de vida.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaPai()));

class TelaPai extends StatefulWidget {
  const TelaPai({super.key});

  @override
  State<TelaPai> createState() => _TelaPaiState();
}

class _TelaPaiState extends State<TelaPai> {
  bool _mostrar = true;
  int _rebuilds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O metodo deactivate')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Rebuilds do pai: $_rebuilds'),
            const SizedBox(height: 16),
            // O bloco so existe na arvore enquanto _mostrar for true.
            if (_mostrar) const BlocoEfemero(),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Este botao SO reconstroi a tela. Observe: nao dispara deactivate.
          FloatingActionButton.extended(
            heroTag: 'rebuild',
            onPressed: () => setState(() => _rebuilds++),
            label: const Text('So reconstruir'),
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 12),
          // Este botao REMOVE o bloco da arvore. Ai sim: deactivate dispara.
          FloatingActionButton.extended(
            heroTag: 'toggle',
            onPressed: () => setState(() => _mostrar = !_mostrar),
            label: Text(_mostrar ? 'Remover bloco' : 'Trazer bloco'),
            icon: const Icon(Icons.power_settings_new),
          ),
        ],
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
  // * O framework chama isto quando REMOVE este State da
  //   arvore. Nao e a cada rebuild: so na remocao.
  @override
  void deactivate() {
    debugPrint('deactivate() -> sai da arvore');
    // ! super por ULTIMO nos callbacks de saida (@mustCallSuper).
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build() do bloco');
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.teal.shade100,
      child: const Text('Estou na arvore'),
    );
  }
}
