// 05_uma_vez_e_mounted.dart
// Demonstra: as duas verdades que evitam bug com addPostFrameCallback.
//   (a) o callback roda UMA vez -- nao repete a cada rebuild;
//   (b) o padrao if (!mounted) return; protege quando o widget saiu da tela.
// Novo em relacao aos anteriores: prova no console que o callback nao volta a
//   rodar quando o setState reconstroi a tela.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaContagem()));

class TelaContagem extends StatefulWidget {
  const TelaContagem({super.key});

  @override
  State<TelaContagem> createState() => _TelaContagemState();
}

class _TelaContagemState extends State<TelaContagem> {
  int _cliques = 0;
  int _vezesQueOPosFrameRodou = 0;

  @override
  void initState() {
    super.initState();

    // Agendamos UMA vez. Mesmo clicando e reconstruindo a tela varias vezes,
    // este callback nao volta a rodar -- o contador abaixo para em 1.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _vezesQueOPosFrameRodou++;
      debugPrint('pos-frame rodou: $_vezesQueOPosFrameRodou vez(es)');
    });
  }

  void _incrementar() {
    // Cada clique dispara um novo build. Olhe o console: o "pos-frame rodou"
    // NAO aparece de novo -- so o build repete.
    setState(() => _cliques++);
    debugPrint('build vai rodar de novo (clique $_cliques)');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Roda uma vez so')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Cliques: $_cliques', style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 12),
            Text('Pos-frame rodou: $_vezesQueOPosFrameRodou vez(es)'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // ! Clique varias vezes: "Pos-frame rodou" fica em 1. O addPostFrameCallback
        //   nao e recorrente -- se precisasse repetir, teria que reagendar.
        onPressed: _incrementar,
        child: const Icon(Icons.add),
      ),
    );
  }
}
