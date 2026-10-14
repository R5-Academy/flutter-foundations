// exemplo_05_animationcontroller.dart
// Demonstra: o caso mais iconico de "tem que dispor" -- o AnimationController.
//   Ele segura um Ticker (vsync: this), um recurso que o proprio Flutter cobra:
//   se o controller for coletado sem dispose, o framework joga um erro de leak em
//   debug. Aqui o par initState/dispose canonico, girando um FlutterLogo.
// Fecha a aula amarrando tudo: um recurso real, o par espelhado, super por ultimo.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaGiro()));

class TelaGiro extends StatefulWidget {
  const TelaGiro({super.key});

  @override
  State<TelaGiro> createState() => _TelaGiroState();
}

class _TelaGiroState extends State<TelaGiro> {
  bool _mostrar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimationController')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_mostrar) const LogoGirando(),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => setState(() => _mostrar = !_mostrar),
              child: Text(_mostrar ? 'Remover animacao' : 'Mostrar animacao'),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoGirando extends StatefulWidget {
  const LogoGirando({super.key});

  @override
  State<LogoGirando> createState() => _LogoGirandoState();
}

// SingleTickerProviderStateMixin fornece o `vsync` que o AnimationController pede:
// o Ticker que dispara um passo da animacao a cada frame.
class _LogoGirandoState extends State<LogoGirando>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState(); // super PRIMEIRO
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // gira em loop
  }

  // * O par do initState: o controller que nasceu la e liberado aqui. Sem este
  //   dispose, o Flutter avisa em debug que o AnimationController vazou.
  @override
  void dispose() {
    _controller.dispose(); // par do AnimationController
    super.dispose(); // super por ULTIMO
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: const FlutterLogo(size: 120),
    );
  }
}
