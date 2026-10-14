// 01_ja_vem_estilizado.dart
// Demonstra: o app JA VEM com um estilo, mesmo sem a gente configurar nada.
// Ponto de partida da aula: nao passamos nenhum theme e, ainda assim, a AppBar
//   tem cor, o botao tem cor e os textos tem tamanhos coerentes.
//
// Por que? O MaterialApp SEMPRE monta um ThemeData padrao (hoje, Material 3).
// Tema nao e algo que a gente "liga" — ja esta ligado; a gente so personaliza.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppSemTema());

class AppSemTema extends StatelessWidget {
  const AppSemTema({super.key});

  @override
  Widget build(BuildContext context) {
    // Repare: nenhum parametro `theme` aqui. O MaterialApp usa o tema padrao.
    return MaterialApp(
      title: 'Sem tema custom',
      home: Scaffold(
        appBar: AppBar(title: const Text('Loja da Academia')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bem-vindo!'),
                SizedBox(height: 16),
                Text('O app ja vem estilizado, mesmo sem a gente pedir.'),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
