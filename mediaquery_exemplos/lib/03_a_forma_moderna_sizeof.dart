// 03_a_forma_moderna_sizeof.dart
// Demonstra: o ponto NOVO mais importante da aula. Em vez de
//   MediaQuery.of(context).size, use MediaQuery.sizeOf(context).
//
// * Por que? MediaQuery.of(context) faz o widget depender do MediaQueryData
// * INTEIRO. Qualquer mudanca (teclado, giro, dark mode) reconstroi o widget.
// * Ja MediaQuery.sizeOf(context) diz: "so me reconstrua quando o TAMANHO mudar".
//
// Prova viva: dois cards leem a MESMA largura, um com .of e outro com .sizeOf.
// Cada um conta quantas vezes reconstruiu. Toque no campo de texto para abrir o
// teclado (isso muda o viewInsets, NAO o size):
//   - o card do .of      -> RECONSTROI (contador sobe), porque depende de tudo.
//   - o card do .sizeOf   -> NAO reconstroi, porque o tamanho nao mudou.
//
// ! Regra pratica: prefira sempre o especifico (sizeOf, orientationOf,
// ! paddingOf, viewInsetsOf...). So use .of quando precisar de varios campos.

import 'package:material_ui/material_ui.dart';

// Contadores de rebuild. Sao globais so para conseguirmos VISUALIZAR quantas
// vezes cada card reconstruiu — normalmente a gente nao faz efeito colateral no
// build; aqui e didatico.
int _buildsComOf = 0;
int _buildsComSizeOf = 0;

void main() => runApp(const AppSizeOf());

class AppSizeOf extends StatelessWidget {
  const AppSizeOf({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'of vs sizeOf',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('MediaQuery.of vs sizeOf')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CardComOf(),
              const SizedBox(height: 12),
              const CardComSizeOf(),
              const Spacer(),
              const Text('Toque aqui e abra o teclado:'),
              const SizedBox(height: 8),
              // Ao focar, o teclado sobe -> muda viewInsets -> so o card .of reconstroi.
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Digite algo...',
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// Depende do MediaQueryData INTEIRO: reconstroi a cada teclado/giro/dark mode.
class CardComOf extends StatelessWidget {
  const CardComOf({super.key});

  @override
  Widget build(BuildContext context) {
    _buildsComOf++;
    final largura = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.red.shade50,
      child: ListTile(
        leading: const Icon(Icons.warning_amber),
        title: Text('MediaQuery.of(context).size'),
        subtitle: Text('Largura: ${largura.toStringAsFixed(0)}'),
        trailing: Text(
          'builds: $_buildsComOf',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Depende SO do tamanho: o teclado abrir nao o reconstroi.
class CardComSizeOf extends StatelessWidget {
  const CardComSizeOf({super.key});

  @override
  Widget build(BuildContext context) {
    _buildsComSizeOf++;
    final largura = MediaQuery.sizeOf(context).width;

    return Card(
      color: Colors.green.shade50,
      child: ListTile(
        leading: const Icon(Icons.check_circle_outline),
        title: Text('MediaQuery.sizeOf(context)'),
        subtitle: Text('Largura: ${largura.toStringAsFixed(0)}'),
        trailing: Text(
          'builds: $_buildsComSizeOf',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
