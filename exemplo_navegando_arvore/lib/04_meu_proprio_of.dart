// 04_meu_proprio_of.dart
// Demonstra: que .of nao tem nada de especial - voce mesmo escreve um. Aqui um
//   widget Carrinho expoe um Carrinho.of(context) feito na mao com
//   findAncestorStateOfType. Um botao la embaixo na arvore chama
//   Carrinho.of(context).adicionar() sem receber nada por parametro - ele SOBE
//   a arvore ate o State do Carrinho. E exatamente o que Scaffold.of faz.
// Novo em relacao ao 03: fechamos a aula escrevendo o proprio .of, entendendo de
//   ponta a ponta o padrao que usamos o tempo todo.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppMeuProprioOf());

class AppMeuProprioOf extends StatelessWidget {
  const AppMeuProprioOf({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Carrinho(child: TelaLoja()));
  }
}

// Carrinho e um StatefulWidget que segura o estado (quantos itens) e o
// disponibiliza para qualquer descendente via Carrinho.of(context).
class Carrinho extends StatefulWidget {
  const Carrinho({super.key, required this.child});

  final Widget child;

  // * Este e o nosso .of feito na mao. Mesmo padrao de Scaffold.of / Navigator.of:
  // * sobe a arvore a partir do context e devolve o State do ancestral Carrinho.
  // * O '!' assume que existe um Carrinho acima (como Scaffold.of, que estoura se nao houver).
  static CarrinhoState of(BuildContext context) {
    return context.findAncestorStateOfType<CarrinhoState>()!;
  }

  @override
  State<Carrinho> createState() => CarrinhoState();
}

// O State e publico (como ScaffoldState) para o .of poder devolve-lo.
class CarrinhoState extends State<Carrinho> {
  int _itens = 0;

  int get itens => _itens;

  void adicionar() => setState(() => _itens++);

  @override
  Widget build(BuildContext context) => widget.child;
}

class TelaLoja extends StatelessWidget {
  const TelaLoja({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu proprio .of')),
      body: const Center(child: BotaoAdicionar()),
    );
  }
}

// Este botao esta bem fundo na arvore e nao recebe o Carrinho por parametro.
// Ele SOBE a arvore com o nosso .of para achar o State e chamar adicionar().
class BotaoAdicionar extends StatelessWidget {
  const BotaoAdicionar({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Sobe a arvore, acha o CarrinhoState e AGE sobre ele.
        final carrinho = Carrinho.of(context);
        carrinho.adicionar();

        // ! findAncestorStateOfType NAO cria dependencia: quem chamou nao rebuilda
        // ! sozinho quando o State muda. Por isso .of de State serve para ACAO
        // ! (como Scaffold.of().openDrawer() ou Navigator.of().push()), nao para
        // ! observar um dado. Aqui lemos o valor no momento do clique e mostramos
        // ! num SnackBar. Observar dado de forma reativa e outro mecanismo
        // ! (InheritedWidget), assunto de fases seguintes.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Itens no carrinho: ${carrinho.itens}'),
            duration: const Duration(milliseconds: 800),
          ),
        );
      },
      // ? Repare: e o mesmo formato de Navigator.of(context).push(...) -
      // ? subir a arvore, achar o State, chamar um metodo. Mesmissimo padrao.
      child: const Text('Adicionar ao carrinho'),
    );
  }
}
