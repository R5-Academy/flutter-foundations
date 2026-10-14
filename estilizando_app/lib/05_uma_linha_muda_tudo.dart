// 05_uma_linha_muda_tudo.dart
// Demonstra: o "momento uau" — trocar a cor semente re-estiliza o app INTEIRO.
// Novo em relacao ao 04: a seedColor deixa de ser fixa. Um StatefulWidget guarda
//   a cor da marca e, com setState, alterna entre roxo e verde. AppBar, botoes,
//   FAB e o nosso CartaoDestaque mudam TODOS juntos — porque todos bebem da mesma
//   paleta gerada pela semente.
//
// * A licao da aula em uma frase: o estilo mora em UM lugar. Mudou a semente,
// * mudou o app. Nada de cacar cor em cada arquivo.
//
// Rode e toque em "Trocar marca": a tela toda troca de cor de uma vez.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppTrocaMarca());

class AppTrocaMarca extends StatefulWidget {
  const AppTrocaMarca({super.key});

  @override
  State<AppTrocaMarca> createState() => _AppTrocaMarcaState();
}

class _AppTrocaMarcaState extends State<AppTrocaMarca> {
  // O estado do app: qual e a cor da marca agora?
  Color _corDaMarca = Colors.deepPurple;

  void _trocarMarca() {
    setState(() {
      // Alterna a semente. So isso — o resto do app se ajusta sozinho.
      _corDaMarca = _corDaMarca == Colors.deepPurple
          ? Colors.teal
          : Colors.deepPurple;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Troca de marca',
      // O tema inteiro deriva de _corDaMarca. Trocou a variavel -> trocou tudo.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _corDaMarca),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Loja da Academia')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CartaoDestaque(titulo: 'Frete gratis hoje!'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Ver produtos'),
                ),
                const SizedBox(height: 8),
                // O unico botao que muda o estado: alterna a cor da marca.
                OutlinedButton.icon(
                  onPressed: _trocarMarca,
                  icon: const Icon(Icons.palette),
                  label: const Text('Trocar marca'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}

// O mesmo cartao do exemplo 04: le o tema com Theme.of(context). Como ele nao
// crava cor, ele acompanha a troca de marca de graca.
class CartaoDestaque extends StatelessWidget {
  const CartaoDestaque({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tema.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        titulo,
        style: tema.textTheme.titleLarge?.copyWith(
          color: tema.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
