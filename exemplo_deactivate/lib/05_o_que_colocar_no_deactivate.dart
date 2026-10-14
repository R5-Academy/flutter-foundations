// 05_o_que_colocar_no_deactivate.dart
// Demonstra: a regra pratica. O deactivate serve para DESFAZER ligacoes externas
//   que valem enquanto o widget esta na arvore; o activate REFAZ essas ligacoes
//   quando ele volta (par simetrico). O painel do pai lista quem esta "ativo": o
//   filho se registra ao entrar e se desregistra no deactivate. Ao mover com
//   GlobalKey, veja o registro sair e voltar, sem perder o State.
// ! Limpeza definitiva (controllers, timers, listeners) NAO vai aqui: vai no
//   dispose (proxima aula). Se voce destruisse um controller no deactivate e o
//   widget fosse reinserido, ele voltaria quebrado.
// Novo em relacao ao 04: mostra o uso REAL (ainda que raro) do deactivate/activate.

import 'package:material_ui/material_ui.dart';

// Um registro simples e externo ao widget (nada de InheritedWidget aqui).
// O pai o mantem e escuta mudancas para mostrar quem esta ativo.
class RegistroDeAtivos extends ChangeNotifier {
  final Set<String> _ativos = {};

  Set<String> get ativos => _ativos;

  void entrar(String id) {
    _ativos.add(id);
    notifyListeners();
  }

  void sair(String id) {
    _ativos.remove(id);
    notifyListeners();
  }
}

void main() => runApp(const MaterialApp(home: TelaPai()));

class TelaPai extends StatefulWidget {
  const TelaPai({super.key});

  @override
  State<TelaPai> createState() => _TelaPaiState();
}

class _TelaPaiState extends State<TelaPai> {
  final _registro = RegistroDeAtivos();
  final _chave = GlobalKey();
  bool _naEsquerda = true;

  @override
  void dispose() {
    // Limpeza definitiva do que o PROPRIO pai criou: fica no dispose.
    _registro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sensor = SensorRegistrado(
      key: _chave,
      id: 'sensor-A',
      registro: _registro,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('O que vai no deactivate')),
      body: Column(
        children: [
          // Mostra em tempo real quem esta registrado como ativo.
          AnimatedBuilder(
            animation: _registro,
            builder: (context, _) => Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Ativos no painel: ${_registro.ativos}'),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _lado('ESQUERDA', _naEsquerda ? sensor : null)),
                Expanded(child: _lado('DIREITA', _naEsquerda ? null : sensor)),
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

  Widget _lado(String titulo, Widget? filho) {
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

class SensorRegistrado extends StatefulWidget {
  const SensorRegistrado({super.key, required this.id, required this.registro});

  final String id;
  final RegistroDeAtivos registro;

  @override
  State<SensorRegistrado> createState() => _SensorRegistradoState();
}

class _SensorRegistradoState extends State<SensorRegistrado> {
  int _leituras = 0;

  @override
  void initState() {
    super.initState();
    // Entra no registro na primeira insercao.
    widget.registro.entrar(widget.id);
  }

  // * Ligacao externa desfeita ao sair da arvore. Se for reinsercao, o activate
  //   refaz logo em seguida; se for saida definitiva, o registro ja fica limpo.
  @override
  void deactivate() {
    widget.registro.sair(widget.id);
    super.deactivate(); // super por ULTIMO
  }

  // * O par: ao voltar para a arvore, refaz o registro no novo lugar.
  @override
  void activate() {
    super.activate(); // super PRIMEIRO
    widget.registro.entrar(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    // O State (as leituras) sobrevive ao mover, porque ha GlobalKey.
    return ElevatedButton(
      onPressed: () => setState(() => _leituras++),
      child: Text('${widget.id}: $_leituras leituras'),
    );
  }
}
