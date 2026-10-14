// 01_o_metodo_dispose.dart
// Demonstra: o metodo dispose em si e a sequencia de saida definitiva. Um cartao
//   vive dentro de um `if (_mostrar)`. Ao removê-lo da arvore, o console mostra
//   deactivate -> dispose, cada um UMA vez. Fixa: dispose = saida definitiva,
//   nao a cada rebuild; e super.dispose() vem por ULTIMO.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaSaida()));

class TelaSaida extends StatefulWidget {
  const TelaSaida({super.key});

  @override
  State<TelaSaida> createState() => _TelaSaidaState();
}

class _TelaSaidaState extends State<TelaSaida> {
  bool _mostrar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O metodo dispose')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Enquanto _mostrar for true o Cartao esta na arvore. Ao virar false
            // ele sai de vez -> deactivate -> dispose.
            if (_mostrar) const Cartao(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => setState(() => _mostrar = !_mostrar),
              child: Text(_mostrar ? 'Remover cartao' : 'Mostrar cartao'),
            ),
          ],
        ),
      ),
    );
  }
}

class Cartao extends StatefulWidget {
  const Cartao({super.key});

  @override
  State<Cartao> createState() => _CartaoState();
}

class _CartaoState extends State<Cartao> {
  @override
  void deactivate() {
    // deactivate dispara primeiro: o State saiu da arvore (pode ate voltar).
    // super por ULTIMO, como todo metodo de saida.
    debugPrint('deactivate -> sai da arvore');
    super.deactivate();
  }

  // * A assinatura oficial: @mustCallSuper garante que o analyzer avisa se voce
  //   esquecer o super.dispose(). Note a ordem: limpeza primeiro, super depois.
  @override
  void dispose() {
    debugPrint('dispose    -> saida DEFINITIVA (limpeza vai aqui)');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Sou o cartao',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
