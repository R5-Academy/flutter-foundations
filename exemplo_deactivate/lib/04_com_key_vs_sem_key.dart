// 04_com_key_vs_sem_key.dart
// Demonstra: o contraste que prova tudo. O MESMO exemplo de mover um contador
//   entre duas colunas, agora com um interruptor "usar GlobalKey?".
//   - Interruptor LIGADO: Flutter reconhece o mesmo widget -> deactivate + activate,
//     SEM dispose, e o contador PRESERVA o valor.
//   - Interruptor DESLIGADO: sem key, o Flutter destroi um lado e cria outro ->
//     deactivate + dispose, e o contador ZERA ao mudar de coluna.
// Novo em relacao ao 03: o antes/depois na mesma tela deixa cristalino por que
//   deactivate NAO e lugar de limpeza definitiva (a reinsercao depende disso).

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaPai()));

class TelaPai extends StatefulWidget {
  const TelaPai({super.key});

  @override
  State<TelaPai> createState() => _TelaPaiState();
}

class _TelaPaiState extends State<TelaPai> {
  final _chave = GlobalKey();
  bool _usarKey = true;
  bool _naEsquerda = true;

  @override
  Widget build(BuildContext context) {
    // Com o interruptor ligado passamos a MESMA GlobalKey; desligado, sem key.
    final contador = Contador(key: _usarKey ? _chave : null);

    return Scaffold(
      appBar: AppBar(title: const Text('Com key vs sem key')),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Usar GlobalKey?'),
            subtitle: Text(
              _usarKey
                  ? 'Preserva o State ao mover (deactivate + activate)'
                  : 'Destroi e recria ao mover (deactivate + dispose)',
            ),
            value: _usarKey,
            onChanged: (v) => setState(() => _usarKey = v),
          ),
          Expanded(
            child: Row(
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
    debugPrint('deactivate() -> saiu da coluna (valor = $_valor)');
    super.deactivate();
  }

  @override
  void activate() {
    super.activate();
    debugPrint('activate() -> reinserido, valor preservado = $_valor');
  }

  @override
  void dispose() {
    // Sem key, este print aparece ao mover -> o contador zera do outro lado.
    debugPrint('dispose() -> destruido, o proximo comeca do zero');
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
