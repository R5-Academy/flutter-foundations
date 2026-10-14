// exemplo_01_o_metodo_e_a_ordem.dart
// Demonstra: a assinatura do didChangeDependencies e a ordem em que ele entra
//   na linha do tempo. O console prova: initState -> didChangeDependencies ->
//   build, com cada um rodando 1x na primeira montagem.
// Novo em relacao a aula de initState: existe um metodo ENTRE o initState e o
//   primeiro build. Ele roda sempre, mesmo sem depender de nada herdado.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaOrdem()));

class TelaOrdem extends StatefulWidget {
  const TelaOrdem({super.key});

  @override
  State<TelaOrdem> createState() => _TelaOrdemState();
}

class _TelaOrdemState extends State<TelaOrdem> {
  @override
  void initState() {
    super.initState();
    debugPrint('1) initState');
  }

  @override
  void didChangeDependencies() {
    // * super sempre como primeira linha (@mustCallSuper). Esquecer gera
    //   aviso do analisador e pode deixar o State inconsistente.
    super.didChangeDependencies();
    debugPrint('2) didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('3) build');
    return Scaffold(
      appBar: AppBar(title: const Text('A ordem no console')),
      body: const Center(
        child: Text('Abra o Debug console e leia a ordem dos prints'),
      ),
    );
  }
}
