// 03_dados_do_widget.dart
// Demonstra: de onde o State pega os dados de configuracao. Resposta: do WIDGET,
//   via `widget.propriedade` — nunca pelo construtor do State.
// Novo em relacao ao 02: agora o widget carrega dados de fora (nome e preco) e o
//   createState continua sendo so a fabrica de uma linha; os dados nao passam por ele.

import 'package:material_ui/material_ui.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CardProduto(nome: 'Teclado mecanico', preco: 349.90),
        ),
      ),
    ),
  );
}

// A configuracao (nome, preco) vive no WIDGET, que e imutavel e feito pra isso.
class CardProduto extends StatefulWidget {
  const CardProduto({super.key, required this.nome, required this.preco});

  final String nome;
  final double preco;

  // createState continua sendo so a fabrica. Repare: nao passamos nome/preco
  // para ca. O State vai buscar esses dados sozinho, no lugar certo.
  @override
  State<CardProduto> createState() => _CardProdutoState();
}

class _CardProdutoState extends State<CardProduto> {
  // O que MUDA por interacao mora no State.
  bool _favorito = false;

  @override
  Widget build(BuildContext context) {
    // * Os dados de configuracao vem do widget, via `widget.xxx`.
    //   Por que assim e nao pelo construtor do State? Porque o framework mantem
    //   `widget` sempre atualizado quando o pai reconstroi com valores novos.
    //   Se copiassemos para um campo do State, esse valor ficaria congelado.
    return ListTile(
      title: Text(widget.nome),
      subtitle: Text('R\$ ${widget.preco.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: Icon(_favorito ? Icons.favorite : Icons.favorite_border),
        onPressed: () => setState(() => _favorito = !_favorito),
      ),
    );
  }
}
