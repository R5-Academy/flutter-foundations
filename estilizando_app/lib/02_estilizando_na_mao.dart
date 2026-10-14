// 02_estilizando_na_mao.dart
// Demonstra: o PROBLEMA que o tema resolve — estilizar cada widget na mao.
// Novo em relacao ao 01: agora queremos a identidade da marca (um roxo) na tela.
//   Sem tema, a unica saida e cravar a cor em CADA widget, um por um.
//
// ! Repare quantas vezes `Colors.deepPurple` aparece aqui embaixo. Se o cliente
// ! pedir para trocar o roxo por verde, vira uma cacada: um por um, em todo lugar.
// ! E basta um esquecido para a tela ficar inconsistente. E essa dor que o
// ! proximo exemplo (03) resolve com um tema.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppNaMao());

class AppNaMao extends StatelessWidget {
  const AppNaMao({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estilizando na mao',
      home: Scaffold(
        appBar: AppBar(
          // Cor cravada #1
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          title: const Text('Loja da Academia'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nossas ofertas',
                  // Cor cravada #2 (e o tamanho tambem na mao)
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  // Cor cravada #3
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Ver produtos'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // Cor cravada #4
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          onPressed: () {},
          child: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
