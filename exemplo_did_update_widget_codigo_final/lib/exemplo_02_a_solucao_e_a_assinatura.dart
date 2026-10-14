// exemplo_02_a_solucao_e_a_assinatura.dart
// Demonstra: didUpdateWidget resolve o "State preso" do exemplo 01. A assinatura
//   com covariant, o super primeiro, e o par oldWidget (antigo) x widget (ja e
//   o novo). O console prova os dois lados lado a lado a cada mudanca do pai.
// Novo em relacao ao 01: agora o campo local acompanha a prop, porque
//   resincronizamos no didUpdateWidget.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaPai()));

class TelaPai extends StatefulWidget {
  const TelaPai({super.key});

  @override
  State<TelaPai> createState() => _TelaPaiState();
}

class _TelaPaiState extends State<TelaPai> {
  int _alvo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A solucao: didUpdateWidget')),
      body: Center(child: PainelAlvo(alvo: _alvo)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => _alvo++),
        label: const Text('Aumentar alvo'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class PainelAlvo extends StatefulWidget {
  const PainelAlvo({super.key, required this.alvo});

  final int alvo;

  @override
  State<PainelAlvo> createState() => _PainelAlvoState();
}

class _PainelAlvoState extends State<PainelAlvo> {
  late int _valorLocal;

  @override
  void initState() {
    super.initState();
    _valorLocal = widget.alvo;
  }

  @override
  void didUpdateWidget(covariant PainelAlvo oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('DidUpdateWidget: de ${oldWidget.alvo} para ${widget.alvo}');
    _valorLocal = widget.alvo;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Prop atual (widget.alvo): ${widget.alvo}'),
        const SizedBox(height: 8),
        Text(
          'Campo local (sincronizado): $_valorLocal',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
