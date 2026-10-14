// exemplo_04_nao_dispara_no_setstate.dart
// Demonstra: o didChangeDependencies NAO roda a cada setState. setState agenda
//   um build; o didChangeDependencies so dispara quando uma dependencia herdada
//   muda. Todo didChangeDependencies traz um build, mas nem todo build vem de um
//   didChangeDependencies.
// Novo em relacao ao 03: desfaz a confusao mais comum -- "achei que rodava a
//   cada mudanca de estado". O console prova o contrario.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaContador()));

class TelaContador extends StatefulWidget {
  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
}

class _TelaContadorState extends State<TelaContador> {
  int _contador = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ! Este print sai UMA vez (apos o initState) e nao volta a cada clique.
    //   Nenhuma dependencia herdada esta mudando quando voce toca no botao.
    debugPrint('didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    // Este sim sai a cada setState: setState -> build.
    debugPrint('build (contador=$_contador)');
    return Scaffold(
      appBar: AppBar(title: const Text('setState nao chama o metodo')),
      body: Center(
        child: Text('Contador: $_contador', style: const TextStyle(fontSize: 32)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _contador++),
        child: const Icon(Icons.add),
      ),
    );
  }
}
