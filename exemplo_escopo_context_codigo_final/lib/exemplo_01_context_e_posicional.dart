import 'package:flutter/material.dart';

void main() => runApp(const AppEscopo());

class AppEscopo extends StatelessWidget {
  const AppEscopo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Tema global do app: cor primária azul.
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Escopo do context')),
        body: Column(
          children: const [
            // * Lê o tema AZUL: o Theme mais próximo acima é o do MaterialApp.
            QuadradoDaCorPrimaria(rotulo: 'Fora do Theme local'),

            TemaLocalVerde(
              // * Lê o tema VERDE: agora existe um Theme local (verde) mais
              // * próximo, acima dele. Mesmo código do quadrado de cima.
              child: QuadradoDaCorPrimaria(rotulo: 'Dentro do Theme local'),
            ),
          ],
        ),
      ),
    );
  }
}

// Embrulha o filho num Theme local (verde). Tudo abaixo dele passa a ler verde.
class TemaLocalVerde extends StatelessWidget {
  final Widget child;
  const TemaLocalVerde({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(colorSchemeSeed: Colors.green),
      child: child,
    );
  }
}

// Lê a cor primária DO SEU próprio context e se pinta com ela.
class QuadradoDaCorPrimaria extends StatelessWidget {
  final String rotulo;
  const QuadradoDaCorPrimaria({super.key, required this.rotulo});

  @override
  Widget build(BuildContext context) {
    // Mesma linha nos dois quadrados. O resultado muda por causa da POSIÇÃO:
    //   cada context sobe a árvore e pega o Theme ancestral mais próximo.
    final cor = Theme.of(context).colorScheme.primary;
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      color: cor,
      child: Text(rotulo, style: const TextStyle(color: Colors.white)),
    );
  }
}
