import 'package:flutter/material.dart';

void main() => runApp(const AppFerramentas());

class AppFerramentas extends StatelessWidget {
  const AppFerramentas({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TelaFerramentas());
  }
}

class TelaFerramentas extends StatelessWidget {
  const TelaFerramentas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ferramentas de subida')),
      drawer: const Drawer(child: Center(child: Text('Menu'))),
      // O Builder da um context ABAIXO do Scaffold, senao a subida ate o
      // ScaffoldState nao acharia nada (o context da tela esta acima do Scaffold).
      body: Builder(
        builder: (context) {
          // * Sobe ate o WIDGET Theme e le uma cor dele.
          final theme = context.findAncestorWidgetOfExactType<Theme>();
          final temTheme = theme != null;

          // * Sobe ate o STATE do Scaffold. E o mesmo que Scaffold.of(context) faz.
          // * Com o State em maos, da pra chamar metodos como openDrawer().
          final scaffoldState = context
              .findAncestorStateOfType<ScaffoldState>();
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Achou um Theme acima? $temTheme'),
                const SizedBox(height: 8),
                Text('Achou um ScaffoldState acima? ${scaffoldState != null}'),
                const SizedBox(height: 24),
                ElevatedButton(
                  // Usamos o State que a subida encontrou para agir na tela.
                  onPressed: () => scaffoldState?.openDrawer(),
                  child: const Text('Abrir Drawer pelo State encontrado'),
                ),
                const SizedBox(height: 8),
                const Text(
                  'findAncestorStateOfType<ScaffoldState> == o motor do Scaffold.of',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
