// 03_um_tema_data.dart
// Demonstra: a SOLUCAO — definir o estilo UMA vez, no MaterialApp, com ThemeData.
// Novo em relacao ao 02: sumiram TODAS as cores cravadas widget a widget. Agora
//   ha uma unica cor semente (seedColor) no topo, e os widgets Material puxam a
//   paleta sozinhos.
//
// * ColorScheme.fromSeed(seedColor: ...) gera a PALETA INTEIRA a partir de uma
// * cor. AppBar, ElevatedButton e FloatingActionButton leem essa paleta sozinhos
// * — nenhum deles tem mais `backgroundColor`/`style` na mao.
//
// Compare com o 02: mesma tela, mesma marca, zero repeticao de cor.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppComTema());

class AppComTema extends StatelessWidget {
  const AppComTema({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App com tema',
      // * O tema do app inteiro, definido em UM lugar so.
      // Nao precisa de useMaterial3: true — no SDK atual ja e o padrao.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        // Sem backgroundColor: a AppBar puxa a cor do tema sozinha.
        appBar: AppBar(title: const Text('Loja da Academia')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Nossas ofertas'),
                const SizedBox(height: 24),
                // Sem style: o botao ja vem no tom da marca.
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Ver produtos'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // Sem backgroundColor: o FAB tambem segue o tema.
          onPressed: () {},
          child: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
