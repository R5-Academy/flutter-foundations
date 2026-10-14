// 02_valor_inicial_do_widget.dart
// Demonstra: usar o initState para SEMEAR o estado a partir de uma prop do
//   widget. O contador comeca num valor inicial que veio do pai, e depois
//   passa a viver por conta propria no State.
// Novo em relacao ao 01: aqui o initState faz trabalho de verdade -- le
//   widget.inicial (ja disponivel) e copia para um campo mutavel do State.

import 'package:material_ui/material_ui.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        // O pai manda o estoque inicial deste produto.
        body: Center(child: ContadorEstoque(inicial: 5)),
      ),
    ),
  );
}

class ContadorEstoque extends StatefulWidget {
  const ContadorEstoque({super.key, required this.inicial});

  // Configuracao imutavel, vinda do pai.
  final int inicial;

  @override
  State<ContadorEstoque> createState() => _ContadorEstoqueState();
}

class _ContadorEstoqueState extends State<ContadorEstoque> {
  // `late` porque o valor so vai existir dentro do initState, nao na declaracao.
  late int _estoque;

  @override
  void initState() {
    super.initState();
    // * Semeia o estado com a prop do widget. A partir daqui, _estoque e do
    //   State: muda com os botoes e nao acompanha mais o widget.inicial.
    _estoque = widget.inicial;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Em estoque: $_estoque', style: const TextStyle(fontSize: 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _estoque > 0 ? () => setState(() => _estoque--) : null,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            IconButton(
              onPressed: () => setState(() => _estoque++),
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        // ? E se o pai mudar `inicial` depois deste widget ja estar na tela?
        //   O _estoque NAO atualiza sozinho: o initState ja rodou e nao repete.
        //   Reagir a prop nova e trabalho do didUpdateWidget (aula futura).
      ],
    );
  }
}
