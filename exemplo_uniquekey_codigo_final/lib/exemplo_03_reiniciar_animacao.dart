// exemplo_03_reiniciar_animacao.dart
// Demonstra: usar UniqueKey para RE-DISPARAR uma animacao implicita. O
//   TweenAnimationBuilder anima uma vez, do begin ao end, quando e' montado.
//   Para toca-la de novo do comeco, recriamos o widget com uma UniqueKey nova:
//   ele nasce outra vez e o tween roda do zero. E' o caso em que nao ha um
//   AnimationController com reset() -- a UniqueKey e' o caminho mais simples.
// Novo em relacao ao 02: o mesmo padrao (trocar a key sob demanda), agora para
//   reiniciar uma transicao visual em vez de zerar campos.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaAnimacao()));

class TelaAnimacao extends StatefulWidget {
  const TelaAnimacao({super.key});

  @override
  State<TelaAnimacao> createState() => _TelaAnimacaoState();
}

class _TelaAnimacaoState extends State<TelaAnimacao> {
  // A key vive no State. Trocar ela recria o TweenAnimationBuilder.
  Key _animKey = UniqueKey();

  void _repetir() => setState(() => _animKey = UniqueKey());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reiniciar animacao com UniqueKey')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              // Sem a key trocando, a animacao so rodaria uma vez (ao montar).
              // Com uma UniqueKey nova a cada clique, o widget renasce e o
              // tween 0 -> 1 dispara de novo, do comeco.
              key: _animKey,
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutBack,
              builder: (context, t, child) {
                return Opacity(
                  opacity: t.clamp(0.0, 1.0),
                  child: Transform.scale(scale: t, child: child),
                );
              },
              child: const Icon(Icons.favorite, size: 120, color: Colors.red),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _repetir,
              icon: const Icon(Icons.replay),
              label: const Text('Repetir'),
            ),
          ],
        ),
      ),
    );
  }
}
