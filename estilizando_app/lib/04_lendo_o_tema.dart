// 04_lendo_o_tema.dart
// Demonstra: ler o tema nos SEUS proprios widgets com Theme.of(context).
// Novo em relacao ao 03: os widgets Material ja puxavam o tema sozinhos. Mas e
//   um widget SEU (um Container, um Text)? Ele nao adivinha a marca — voce LE o
//   tema com Theme.of(context) e aplica.
//
// * Theme.of(context) devolve o ThemeData em vigor. Dele saem:
// *   - colorScheme  -> a paleta (primary, onPrimary, surface, ...)
// *   - textTheme    -> os estilos de texto (titleLarge, bodyMedium, ...)
// Isso e "consumo" do tema: define-se UMA vez (no MaterialApp), le-se onde precisar.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppLendoTema());

class AppLendoTema extends StatelessWidget {
  const AppLendoTema({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lendo o tema',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Loja da Academia')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            // Nosso widget proprio, que vai seguir a marca sem receber cor nenhuma.
            child: CartaoDestaque(titulo: 'Frete gratis hoje!'),
          ),
        ),
      ),
    );
  }
}

// Um cartao feito por nos (nao e um widget Material pronto). Mesmo assim ele
// segue a identidade do app — porque LE o tema em vez de cravar cores.
class CartaoDestaque extends StatelessWidget {
  const CartaoDestaque({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    // Guardamos o tema numa variavel para nao repetir Theme.of(context) toda hora.
    final tema = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // A cor principal da marca, vinda do tema — nao cravada.
        color: tema.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        titulo,
        style: tema.textTheme.titleLarge?.copyWith(
          // ! onPrimary e a cor que se le EM CIMA de primary — texto sempre legivel.
          color: tema.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
