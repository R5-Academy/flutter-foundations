// exemplo_05_a_armadilha_do_context.dart
// Demonstra: a armadilha classica do initState -- ler dependencias herdadas
//   (Theme.of / MediaQuery.of) aqui QUEBRA o app. Mostra o erro comentado e a
//   forma certa lado a lado.
// Novo em relacao ao 04: a regra critica do context no initState e para onde
//   essa leitura deve ir (o build agora; o didChangeDependencies na proxima aula).

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaTema()));

class TelaTema extends StatefulWidget {
  const TelaTema({super.key});

  @override
  State<TelaTema> createState() => _TelaTemaState();
}

class _TelaTemaState extends State<TelaTema> {
  @override
  void initState() {
    super.initState();

    // ! ERRADO: descomente e o app quebra em debug com:
    //   "dependOnInheritedWidgetOfExactType<...>() ... was called before
    //    _TelaTemaState.initState() completed."
    //   Theme.of e MediaQuery.of registram uma DEPENDENCIA herdada, e o
    //   framework proibe isso no initState -- a dependencia nao seria respeitada.
    //
    // final cor = Theme.of(context).colorScheme.primary;
    // final largura = MediaQuery.of(context).size.width;

    // O `context` EXISTE aqui (o State ja esta montado, mounted e true). A
    // restricao e especifica: nao usar o context para buscar dependencias
    // herdadas (.of) dentro do initState.
  }

  @override
  Widget build(BuildContext context) {
    // * CERTO: leia Theme.of / MediaQuery.of aqui, no build. O build roda
    //   depois do initState e reage sozinho quando o tema ou o tamanho mudam.
    //   O lugar canonico do ciclo de vida para isso e o didChangeDependencies
    //   -- nossa proxima aula.
    final cor = Theme.of(context).colorScheme.primary;
    final largura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Tema e tela')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.palette, size: 64, color: cor),
            const SizedBox(height: 12),
            Text('Largura da tela: ${largura.toStringAsFixed(0)} px'),
          ],
        ),
      ),
    );
  }
}
