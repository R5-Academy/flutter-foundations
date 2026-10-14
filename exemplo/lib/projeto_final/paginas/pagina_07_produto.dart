// pagina_07_produto.dart
// Exemplo 07 — o "depois" em escala real: a mesma tela de produto composta por
// widgets pequenos de widgets/. O build da página lê como um índice, tudo const.

import 'package:material_ui/material_ui.dart';

import '../widgets/barra_avaliacao.dart';
import '../widgets/botao_adicionar_carrinho.dart';
import '../widgets/produto_cabecalho.dart';
import '../widgets/produto_descricao.dart';
import '../widgets/produto_imagem.dart';
import '../widgets/secao_avaliacoes.dart';
import '../widgets/seletor_cores.dart';

class PaginaProduto extends StatelessWidget {
  const PaginaProduto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe do produto')),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
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
