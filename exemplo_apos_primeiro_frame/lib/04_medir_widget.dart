// 04_medir_widget.dart
// Demonstra: uso real. Descobrir a largura REAL de um widget na tela -- algo que
//   so existe depois do layout. Aqui medimos um card e mostramos a largura.
// Novo em relacao ao 03: GlobalKey para achar o RenderBox e ler .size no
//   pos-frame; depois um setState para exibir a medida.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaMedicao()));

class TelaMedicao extends StatefulWidget {
  const TelaMedicao({super.key});

  @override
  State<TelaMedicao> createState() => _TelaMedicaoState();
}

class _TelaMedicaoState extends State<TelaMedicao> {
  // A chave liga este State ao elemento renderizado do card no build.
  final _cardKey = GlobalKey();

  Size? _tamanho; // null enquanto ainda nao medimos

  @override
  void initState() {
    super.initState();

    // * O tamanho so existe depois do layout. No initState o RenderBox nem
    //   foi criado. No pos-frame ele ja tem dimensoes calculadas.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final render = _cardKey.currentContext?.findRenderObject() as RenderBox?;
      setState(() => _tamanho = render?.size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medindo um widget')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              key: _cardKey, // marcamos o widget que queremos medir
              child: const Padding(
                padding: EdgeInsets.all(24),
                child: Text('Card de produto', textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _tamanho == null
                  ? 'Medindo...'
                  : 'Largura real do card: '
                        '${_tamanho!.width.toStringAsFixed(1)} px',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
