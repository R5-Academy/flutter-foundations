// pagina_06_produto_inchada.dart
// Exemplo 06 — o "antes" em escala real: a tela de detalhe de produto inteira
// num único build gigante, com blocos repetidos (cores e avaliações).

import 'package:material_ui/material_ui.dart';

class PaginaProdutoInchada extends StatelessWidget {
  const PaginaProdutoInchada({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe do produto (inchado)')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----- imagem -----
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFECEFF1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.headphones,
                  size: 96,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 16),

              // ----- nome + preço -----
              const Text(
                'Fone Bluetooth XTR',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'R\$ 299,90',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              // ----- avaliação -----
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star_half, color: Colors.amber, size: 20),
                  SizedBox(width: 8),
                  Text(
                    '4.5 (128 avaliações)',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ----- descrição -----
              const Text(
                'Descrição',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Fone sem fio com cancelamento de ruído, 30h de bateria e '
                'estojo de carregamento rápido. Ideal para foco e chamadas.',
              ),
              const SizedBox(height: 16),

              // ----- cores (chips repetidos) -----
              const Text(
                'Cores',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Preto'),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Branco'),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Azul'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ----- avaliações (reviews repetidos) -----
              const Text(
                'Avaliações',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(child: Icon(Icons.person)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ana Souza',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Melhor fone que já tive. Bateria dura muito!'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(child: Icon(Icons.person)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bruno Lima',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Cancelamento de ruído excelente.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(child: Icon(Icons.person)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Carla Dias',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Bom custo-benefício, recomendo.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ----- botão -----
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Adicionar ao carrinho'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
