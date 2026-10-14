// 04_consumo_theme_mediaquery_scaffold.dart
// Demonstra: o padrão de CONSUMO no dia a dia. Três chamadas .of(context)
//   diferentes, todas partindo do MESMO ponto, cada uma subindo a árvore e pegando
//   o seu ancestral: Theme, MediaQuery e Scaffold.
// Novo em relação aos anteriores: junta tudo num uso real e mostra dois detalhes
//   práticos — MediaQuery.sizeOf (mais eficiente que o .of quando só quero o
//   tamanho) e a diferença entre .of (estoura se não achar) e .maybeOf (devolve null).

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppConsumo());

class AppConsumo extends StatelessWidget {
  const AppConsumo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple),
      home: const TelaConsumo(),
    );
  }
}

class TelaConsumo extends StatelessWidget {
  const TelaConsumo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Só consumo')),
      // Builder para termos um context ABAIXO do Scaffold (lição do exemplo 02).
      body: Builder(
        builder: (context) {
          // Cada linha sobe a árvore e pega o provedor ancestral mais próximo:
          final tema = Theme.of(context); // ThemeData
          // * sizeOf: só o tamanho. Reconstrói só quando o TAMANHO muda — mais
          // * eficiente que Theme.of/MediaQuery.of, que reagem a qualquer mudança.
          final largura = MediaQuery.sizeOf(context).width;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Largura da tela: ${largura.toStringAsFixed(0)} px',
                  style: TextStyle(color: tema.colorScheme.primary),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Scaffold.of funciona porque estamos dentro do Builder (abaixo).
                    Scaffold.of(context).showBottomSheet(
                      (_) => const SizedBox(
                        height: 120,
                        child: Center(
                          child: Text('Bottom sheet aberto via Scaffold.of'),
                        ),
                      ),
                    );
                  },
                  child: const Text('Abrir bottom sheet'),
                ),
                const SizedBox(height: 8),
                // .maybeOf: mesma busca, mas devolve null em vez de estourar quando
                //   o provedor pode legitimamente não existir acima.
                Text(
                  Scaffold.maybeOf(context) != null
                      ? 'Achei um Scaffold acima (maybeOf != null)'
                      : 'Sem Scaffold acima (maybeOf == null)',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
