// 03_ponto_de_partida.dart
// Demonstra: quem decide o resultado da subida e o CONTEXT que voce passa, nao a
//   chamada. O mesmo MediaQuery.sizeOf lido de dois pontos diferentes da arvore
//   devolve valores diferentes, porque interpomos um MediaQuery no meio.
//   Quem esta ABAIXO do MediaQuery falso enxerga o valor falso; quem esta ACIMA
//   enxerga o real.
// Novo em relacao ao 02: aqui o foco nao e QUAL metodo, e sim de QUAL ponto a
//   subida comeca. Mesma chamada, contextos diferentes, resultados diferentes.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppPontoDePartida());

class AppPontoDePartida extends StatelessWidget {
  const AppPontoDePartida({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TelaPontoDePartida());
  }
}

class TelaPontoDePartida extends StatelessWidget {
  const TelaPontoDePartida({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O context e o ponto de partida')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Este Builder da um context ACIMA do MediaQuery falso.
            // A subida do sizeOf encontra o MediaQuery REAL da tela.
            Builder(
              builder: (ctx) => Text(
                'Largura REAL da tela: ${MediaQuery.sizeOf(ctx).width.toStringAsFixed(0)}',
                style: Theme.of(ctx).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 24),

            // * Interpomos um MediaQuery com um tamanho inventado.
            MediaQuery(
              data: MediaQuery.of(context).copyWith(size: const Size(100, 100)),
              child: Builder(
                // Este ctx nasce ABAIXO do MediaQuery falso.
                // A MESMA chamada sizeOf agora para no MediaQuery falso: le 100.
                builder: (ctx) => Text(
                  'Largura FALSA (abaixo do MediaQuery): '
                  '${MediaQuery.sizeOf(ctx).width.toStringAsFixed(0)}',
                  style: Theme.of(ctx).textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Mesma chamada, dois contextos.\n'
              'O context decide onde a subida comeca — e onde ela para.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
