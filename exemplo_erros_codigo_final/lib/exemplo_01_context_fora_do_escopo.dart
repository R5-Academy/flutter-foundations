import 'package:flutter/material.dart';

void main() => runApp(const AppEscopo());

class AppEscopo extends StatelessWidget {
  const AppEscopo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TelaComDrawer());
  }
}

class TelaComDrawer extends StatelessWidget {
  const TelaComDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // * Este `context` e o do build de TelaComDrawer: ele aponta para a
    // * posicao DESTE widget, que fica ACIMA do Scaffold retornado abaixo.
    return Scaffold(
      appBar: AppBar(title: const Text('Erro #1: context fora do escopo')),
      drawer: const Drawer(child: Center(child: Text('Menu lateral'))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ! NAO FUNCIONA: Scaffold.of sobe a arvore a partir deste context,
          // ! que esta ACIMA do Scaffold. Ao tocar, estoura em runtime:
          // ! Scaffold.of() called with a context that does not contain a Scaffold.
          // ! (A mesma causa gera "No Navigator" e "No MaterialLocalizations found".)
          ElevatedButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            child: const Text('Abrir (FALHA — context de fora)'),
          ),
          const SizedBox(height: 16),

          // * CORRECAO A: extrair um widget filho. Dentro do build do
          // * _BotaoAbrir, o context ja nasce ABAIXO do Scaffold.
          const _BotaoAbrir(),
          const SizedBox(height: 16),

          // * CORRECAO B: Builder. Ele so existe para dar um novo context no
          // * ponto onde esta montado — e aqui isso e ABAIXO do Scaffold.
          Builder(
            builder: (innerContext) {
              return ElevatedButton(
                onPressed: () => Scaffold.of(innerContext).openDrawer(),
                child: const Text('Abrir (OK — Builder)'),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Widget filho extraido: seu proprio context ja esta abaixo do Scaffold da tela.
class _BotaoAbrir extends StatelessWidget {
  const _BotaoAbrir();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Scaffold.of(context).openDrawer(),
      child: const Text('Abrir (OK — widget extraido)'),
    );
  }
}
