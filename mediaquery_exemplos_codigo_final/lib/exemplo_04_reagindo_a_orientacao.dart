import 'package:flutter/material.dart';

void main() => runApp(const AppOrientacao());

class AppOrientacao extends StatelessWidget {
  const AppOrientacao({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orientacao',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Card que gira')),
        body: const Center(
          child: Padding(padding: EdgeInsets.all(24), child: CardProduto()),
        ),
      ),
    );
  }
}

class CardProduto extends StatelessWidget {
  const CardProduto({super.key});

  @override
  Widget build(BuildContext context) {
    // Especifico: so reconstroi quando a orientacao muda.
    final orientacao = MediaQuery.orientationOf(context);
    final emPe = orientacao == Orientation.portrait;

    // A foto e o texto sao os mesmos; muda so o arranjo.
    const foto = _Foto();
    const texto = _Descricao();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        // Um if escolhe entre empilhar (Column) e lado a lado (Row).
        child: emPe
            ? const Column(
                mainAxisSize: MainAxisSize.min,
                children: [foto, SizedBox(height: 16), texto],
              )
            : const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  foto,
                  SizedBox(width: 16),
                  Flexible(child: texto),
                ],
              ),
      ),
    );
  }
}

class _Foto extends StatelessWidget {
  const _Foto();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.headphones, size: 72),
    );
  }
}

class _Descricao extends StatelessWidget {
  const _Descricao();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fone Bluetooth', style: TextStyle(fontSize: 20)),
        SizedBox(height: 8),
        Text('R\$ 199,90'),
      ],
    );
  }
}
