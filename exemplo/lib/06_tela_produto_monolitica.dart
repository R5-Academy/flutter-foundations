// 06_tela_produto_monolitica.dart
// PONTO 1 (em escala real) — uma TELA COMPLETA de detalhe de produto, montada
// INTEIRA num único build. É o "antes": muitos widgets, muito aninhamento,
// blocos repetidos (as avaliações), várias responsabilidades no mesmo lugar.
//
// Role o arquivo: é longo, cansa de ler, e achar "onde está o preço" ou "onde
// está a lista de avaliações" exige caçar no meio da escada de indentação.
// Esse é exatamente o problema que a refatoração do 07 resolve.
//
// (Scaffold, AppBar, Row, Column, Container etc. são o veículo da tela — layout
// de verdade é fase seguinte; o foco aqui é o TAMANHO e a falta de fronteiras.)

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaProduto()));

class TelaProduto extends StatelessWidget {
  const TelaProduto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe do produto')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----- imagem do produto -----
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

              // ----- avaliação (estrelas) -----
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

              // ----- seletor de cores (blocos de chip REPETIDOS) -----
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

              // ----- avaliações (blocos de review REPETIDOS) -----
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

              // ----- botão de ação -----
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
