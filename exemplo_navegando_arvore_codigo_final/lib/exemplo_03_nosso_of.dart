import 'package:flutter/material.dart';

void main() => runApp(AppMeuProprioOf());

class AppMeuProprioOf extends StatelessWidget {
  const AppMeuProprioOf({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Carrinho(child: TelaLoja()));
  }
}

class Carrinho extends StatefulWidget {
  const Carrinho({super.key, required this.child});

  final Widget child;

  static CarrinhoState of(BuildContext context) =>
      context.findAncestorStateOfType<CarrinhoState>()!;

  @override
  State<Carrinho> createState() => CarrinhoState();
}

class CarrinhoState extends State<Carrinho> {
  int _itens = 0;

  int get itens => _itens;

  void adicionar() => setState(() => _itens++);

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class TelaLoja extends StatelessWidget {
  const TelaLoja({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loja')),
      body: Center(child: BotaoAdicionar()),
    );
  }
}

class BotaoAdicionar extends StatelessWidget {
  const BotaoAdicionar({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // final carrinho = context.findAncestorStateOfType<CarrinhoState>();
        final carrinho = Carrinho.of(context);
        carrinho.adicionar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Itens do Carrinho: ${carrinho.itens ?? 'Nenhum item no carrinho'}',
            ),
            duration: Duration(milliseconds: 800),
          ),
        );
      },
      child: const Text('Adicionar'),
    );
  }
}
