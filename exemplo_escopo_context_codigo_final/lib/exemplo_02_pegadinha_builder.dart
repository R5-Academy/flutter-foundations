import 'package:flutter/material.dart';

void main() => runApp(const AppBuilder());

class AppBuilder extends StatelessWidget {
  const AppBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TelaComDrawer());
  }
}

class TelaComDrawer extends StatelessWidget {
  const TelaComDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Builder e escopo')),
      drawer: const Drawer(child: Center(child: Text('Menu'))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ! NÃO FUNCIONA: este 'context' é o do build de TelaComDrawer, que está
          // ! ACIMA do Scaffold. Scaffold.of sobe a partir daqui e não acha nada.
          Center(
            child: ElevatedButton(
              onPressed: () {
                // ! Erro em runtime ao tocar:
                // ! Scaffold.of() called with a context that does not contain a Scaffold.
                Scaffold.of(context).openDrawer();
              },
              child: const Text('Botão de FORA (falha)'),
            ),
          ),

          // * FUNCIONA: o Builder acrescenta um nó à árvore e, com ele, um novo
          // * context — que nasce ABAIXO do Scaffold. A partir dele, Scaffold.of acha.
          Builder(
            builder: (BuildContext contextInterno) {
              return Center(
                child: ElevatedButton(
                  onPressed: () => Scaffold.of(contextInterno).openDrawer(),
                  child: const Text('Botão de DENTRO do Builder (ok)'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
