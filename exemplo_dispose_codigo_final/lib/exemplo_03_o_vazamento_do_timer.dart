// exemplo_03_o_vazamento_do_timer.dart
// Demonstra: o vazamento (memory leak) quando um Timer.periodic NAO e cancelado
//   no dispose, e a correcao ao lado. Dois relogios que voce liga/desliga: o
//   VAZANDO continua imprimindo no console mesmo depois de sair da arvore; o
//   CORRETO para na hora. O aprendizado mora no console -- deixe-o a vista.

import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaVazamento()));

class TelaVazamento extends StatefulWidget {
  const TelaVazamento({super.key});

  @override
  State<TelaVazamento> createState() => _TelaVazamentoState();
}

class _TelaVazamentoState extends State<TelaVazamento> {
  bool _mostrarVazando = false;
  bool _mostrarCorreto = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vazamento do Timer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Olhe o console (Debug console) enquanto liga e desliga.',
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Relogio VAZANDO (sem cancel)'),
              value: _mostrarVazando,
              onChanged: (v) => setState(() => _mostrarVazando = v),
            ),
            if (_mostrarVazando) const RelogioVazando(),
            const Divider(height: 32),
            SwitchListTile(
              title: const Text('Relogio CORRETO (cancel no dispose)'),
              value: _mostrarCorreto,
              onChanged: (v) => setState(() => _mostrarCorreto = v),
            ),
            if (_mostrarCorreto) const RelogioCorreto(),
          ],
        ),
      ),
    );
  }
}

// ! O JEITO ERRADO: dispara um Timer.periodic e nunca guarda a referencia para
//   cancelar. Ao desligar o switch, o State sai da arvore e o dispose roda -- mas
//   o timer continua vivo no relogio do app, imprimindo para sempre. Ligue e
//   desligue duas vezes: agora sao DOIS timers imprimindo em paralelo.
class RelogioVazando extends StatefulWidget {
  const RelogioVazando({super.key});

  @override
  State<RelogioVazando> createState() => _RelogioVazandoState();
}

class _RelogioVazandoState extends State<RelogioVazando> {
  int _tick = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (_) {
      _tick++;
      debugPrint('[VAZANDO] ainda vivo! tick = $_tick');
    });
  }

  @override
  void dispose() {
    // Nada foi cancelado -> o timer sobrevive a este dispose. Vazamento.
    debugPrint('[VAZANDO] dispose (mas o timer continua rodando...)');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const Text('Timer sem cancel');
}

// * O JEITO CERTO: guarda o Timer num campo e cancela no dispose. O par de
//   Timer.periodic e .cancel(). Ao desligar, os prints param na hora.
class RelogioCorreto extends StatefulWidget {
  const RelogioCorreto({super.key});

  @override
  State<RelogioCorreto> createState() => _RelogioCorretoState();
}

class _RelogioCorretoState extends State<RelogioCorreto> {
  Timer? _timer;
  int _tick = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tick++;
      debugPrint('[CORRETO] tick = $_tick');
    });
  }

  @override
  void dispose() {
    debugPrint('Dispose chamado');
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const Text('Timer com cancel');
}
