// exemplo_01_o_state_fica_preso.dart
// Demonstra: o problema que motiva o didUpdateWidget. O State sobrevive aos
//   rebuilds do pai, entao um campo copiado da prop no initState fica PRESO no
//   valor inicial -- initState nao roda de novo.
// Ainda SEM didUpdateWidget de proposito: aqui a gente cria a tensao. No
//   exemplo 02 vem a solucao.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaPai()));

// O pai: tem um alvo que muda quando clicamos no botao (setState do proprio
// pai). A cada clique ele reconstroi e passa um novo valor de alvo para o filho.
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
      appBar: AppBar(title: const Text('O State fica preso')),
      body: Center(
        // O pai reconstroi e manda um alvo novo. Mas o filho NAO acompanha.
        child: PainelAlvo(alvo: _alvo),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => _alvo++),
        label: const Text('Aumentar alvo'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

// O filho: recebe o alvo por prop e o COPIA para um campo no initState.
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
    // ! initState roda UMA vez. Este campo congela no alvo inicial (0) e nunca
    //   mais e atualizado -- mesmo o pai mandando valores novos.
    _valorLocal = widget.alvo;
  }

  @override
  Widget build(BuildContext context) {
    // widget.alvo (o que o pai mandou agora) ja mudou; _valorLocal ficou preso.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Prop atual (widget.alvo): ${widget.alvo}'),
        const SizedBox(height: 8),
        Text(
          'Campo local (preso): $_valorLocal',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
