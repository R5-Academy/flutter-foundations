// 07_tela_produto_refatorada.dart
// PONTO 1 (em escala real) — a MESMA tela do 06, agora refatorada. A tela
// desenhada é IDÊNTICA; o código é outra história.
//
// ORGANIZAÇÃO: cada widget menor mora em seu PRÓPRIO ARQUIVO, na pasta
// `07_tela_produto_refatorada/` ao lado deste. Este arquivo só importa as peças
// e as compõe — como um projeto Flutter de verdade é organizado.
//
// Compare com o 06: lá, achar "o preço" ou "as avaliações" era caçar no meio de
// um build gigante. Aqui, o build da tela é uma LISTA DE NOMES — ele se lê como
// o índice da tela. E cada peça, no seu arquivo, é fácil de achar, testar e
// reusar. Repare também que a árvore inteira ficou `const`.
//
// Quais sinais do 06 justificaram cada extração:
//   • blocos com nome próprio  → ProdutoImagem, ProdutoCabecalho, ProdutoDescricao
//   • repetição                → ChipCor (3 chips iguais) e ItemAvaliacao (3 reviews)
//   • responsabilidade agrupada→ SeletorCores, SecaoAvaliacoes, BarraAvaliacao

import 'package:material_ui/material_ui.dart';

import '07_tela_produto_refatorada/barra_avaliacao.dart';
import '07_tela_produto_refatorada/botao_adicionar_carrinho.dart';
import '07_tela_produto_refatorada/produto_cabecalho.dart';
import '07_tela_produto_refatorada/produto_descricao.dart';
import '07_tela_produto_refatorada/produto_imagem.dart';
import '07_tela_produto_refatorada/secao_avaliacoes.dart';
import '07_tela_produto_refatorada/seletor_cores.dart';

void main() => runApp(const MaterialApp(home: TelaProduto()));

class TelaProduto extends StatelessWidget {
  const TelaProduto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe do produto')),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          // O build da tela lê como um índice: imagem, cabeçalho, avaliação,
          // descrição, cores, avaliações e o botão. Tudo const.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProdutoImagem(icone: Icons.headphones),
              SizedBox(height: 16),
              ProdutoCabecalho(nome: 'Fone Bluetooth XTR', preco: 'R\$ 299,90'),
              SizedBox(height: 12),
              BarraAvaliacao(nota: 4.5, totalAvaliacoes: 128),
              SizedBox(height: 16),
              ProdutoDescricao(
                texto:
                    'Fone sem fio com cancelamento de ruído, 30h de bateria e '
                    'estojo de carregamento rápido. Ideal para foco e chamadas.',
              ),
              SizedBox(height: 16),
              SeletorCores(cores: ['Preto', 'Branco', 'Azul']),
              SizedBox(height: 16),
              SecaoAvaliacoes(),
              SizedBox(height: 16),
              BotaoAdicionarCarrinho(),
            ],
          ),
        ),
      ),
    );
  }
}
