// exemplo_02_o_par_espelhado.dart
// Demonstra: o modelo mental do par espelhado initState <-> dispose. Tudo que
//   nasce/assina la em cima, morre/limpa aqui embaixo. Aqui um
//   TextEditingController: criado no initState, liberado no dispose. Um campo de
//   busca que conta os caracteres em tempo real.
// A regra de ouro da aula: uma criacao sem a limpeza correspondente e um bug.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaBusca()));

class TelaBusca extends StatefulWidget {
  const TelaBusca({super.key});

  @override
  State<TelaBusca> createState() => _TelaBuscaState();
}

class _TelaBuscaState extends State<TelaBusca> {
  late final TextEditingController _controller;
  int _quantidade = 0;

  @override
  void initState() {
    super.initState(); // super PRIMEIRO no initState
    // Criado 1x aqui. O par de cada linha aparece espelhado la no dispose.
    _controller = TextEditingController();
    _controller.addListener(_aoDigitar);
  }

  void _aoDigitar() {
    setState(() => _quantidade = _controller.text.length);
  }

  // * O espelho do initState, na ordem inversa: primeiro removo o listener,
  //   depois libero o controller, e o super.dispose() fica por ULTIMO.
  @override
  void dispose() {
    _controller.removeListener(_aoDigitar); // par do addListener
    _controller.dispose(); // par do TextEditingController()
    super.dispose(); // super por ULTIMO no dispose
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Par espelhado')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'O que voce procura?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Text('$_quantidade caracteres digitados'),
          ],
        ),
      ),
    );
  }
}
