// 03_reinsercao_preserva_o_state.dart
// Demonstra: o CORACAO da aula. Um mesmo Contador carrega uma GlobalKey e e
//   movido de uma coluna para a outra. Como a GlobalKey identifica "e o mesmo
//   widget", o Flutter TRANSPLANTA o State em vez de recriar: chama deactivate()
//   (saiu do lugar antigo) e depois activate() (entrou no novo), SEM dispose.
//   Resultado: o contador PRESERVA o valor ao mudar de coluna.
// Novo em relacao ao 02: aparece a reinsercao (o caso em que dispose NAO vem) e
//   o par activate(). GlobalKey e semente da proxima secao (Keys).

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaPai()));

class TelaPai extends StatefulWidget {
  const TelaPai({super.key});

  @override
  State<TelaPai> createState() => _TelaPaiState();
}

class _TelaPaiState extends State<TelaPai> {
  // * A MESMA GlobalKey acompanha o widget aonde quer que ele va na arvore.
  final _chave = GlobalKey();
  bool _naEsquerda = true;

  @override
  Widget build(BuildContext context) {
    // O contador leva a _chave: por ela o Flutter reconhece que e o mesmo widget.
    final contador = Contador(key: _chave);

    return Scaffold(
      appBar: AppBar(title: const Text('Reinsercao com GlobalKey')),
      body: Row(
        children: [
          Expanded(
            child: Coluna(
              titulo: 'ESQUERDA',
              filho: _naEsquerda ? contador : null,
            ),
          ),
          Expanded(
            child: Coluna(
              titulo: 'DIREITA',
              filho: _naEsquerda ? null : contador,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => _naEsquerda = !_naEsquerda),
        label: const Text('Mover'),
        icon: const Icon(Icons.swap_horiz),
      ),
    );
  }
}

class Coluna extends StatelessWidget {
  const Coluna({super.key, required this.titulo, this.filho});

  final String titulo;
  final Widget? filho;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ?filho,
        ],
      ),
    );
  }
}

class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int _valor = 0;

  @override
  void deactivate() {
    // Saiu do lugar antigo. Como ha reinsercao, NAO vira dispose.
    debugPrint('deactivate() -> saiu da coluna, valor preservado = $_valor');
    super.deactivate();
  }

  // * O par de deactivate na reinsercao. Chamado quando o State volta a arvore
  //   no novo lugar. super vem PRIMEIRO aqui (callback de "entrada").
  @override
  void activate() {
    super.activate();
    debugPrint('activate() -> entrou na nova coluna, valor continua = $_valor');
  }

  @override
  void dispose() {
    // ! Com a GlobalKey preservando o State, este print NAO aparece ao mover.
    debugPrint('dispose() -> destruido de vez');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => setState(() => _valor++),
      child: Text('Cliques: $_valor'),
    );
  }
}
