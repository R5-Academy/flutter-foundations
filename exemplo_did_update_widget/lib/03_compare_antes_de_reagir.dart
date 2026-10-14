// 03_compare_antes_de_reagir.dart
// Demonstra: didUpdateWidget roda em TODO rebuild do pai -- inclusive quando a
//   prop que interessa nao mudou. O if (oldWidget.x != widget.x) evita refazer
//   trabalho caro a toa.
// Novo em relacao ao 02: o pai tem dois botoes. Um muda a prop; o outro so
//   forca um rebuild sem mexer na prop. O console mostra o metodo rodando
//   sempre, mas o "trabalho pesado" so quando o if passa.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaPai()));

class TelaPai extends StatefulWidget {
  const TelaPai({super.key});

  @override
  State<TelaPai> createState() => _TelaPaiState();
}

class _TelaPaiState extends State<TelaPai> {
  int _filtro = 0;
  int _rebuilds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compare antes de reagir')),
      body: Center(child: Lista(filtro: _filtro)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'muda',
            onPressed: () => setState(() => _filtro++),
            label: const Text('Mudar filtro'),
            icon: const Icon(Icons.filter_alt),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'rebuild',
            // Muda um estado que o filho NAO usa: o pai reconstroi, mas a prop
            // filtro continua a mesma.
            onPressed: () => setState(() => _rebuilds++),
            label: const Text('So reconstruir'),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

class Lista extends StatefulWidget {
  const Lista({super.key, required this.filtro});

  final int filtro;

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  int _recargas = 0;

  @override
  void didUpdateWidget(covariant Lista oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('didUpdateWidget chamado (sempre que o pai reconstroi)');

    // * O guarda-chuva. So faz o trabalho caro quando a prop relevante mudou.
    //   Sem este if, "recarregar a lista" rodaria ate quando so o pai piscou.
    if (oldWidget.filtro != widget.filtro) {
      _recargas++;
      debugPrint('  -> filtro mudou: recarregando a lista ($_recargas)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Filtro: ${widget.filtro}'),
        const SizedBox(height: 8),
        Text(
          'Recargas de verdade: $_recargas',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Veja o console: o metodo roda nos dois botoes,\n'
          'mas a recarga so acontece no "Mudar filtro".',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
