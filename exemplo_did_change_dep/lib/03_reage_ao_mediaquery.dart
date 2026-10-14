// 03_reage_ao_mediaquery.dart
// Demonstra: "dependencia herdada" nao e so o tema. O MediaQuery tambem e um
//   ancestral consultado com .of(context). Girar o device ou redimensionar a
//   janela muda o MediaQuery e re-dispara o didChangeDependencies.
// Novo em relacao ao 02: a mesma regra vale para outra dependencia herdada.
//   Aqui a largura da tela decide o numero de colunas da grade.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaGrade()));

class TelaGrade extends StatefulWidget {
  const TelaGrade({super.key});

  @override
  State<TelaGrade> createState() => _TelaGradeState();
}

class _TelaGradeState extends State<TelaGrade> {
  late int _colunas;
  late double _largura;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // MediaQuery.of registra dependencia herdada, igual ao Theme.of. Seguro
    // aqui; proibido no initState.
    _largura = MediaQuery.of(context).size.width;
    _colunas = _largura > 600 ? 3 : 2;
    debugPrint('largura=${_largura.toStringAsFixed(0)} -> colunas=$_colunas');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reagindo ao MediaQuery')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.count(
          crossAxisCount: _colunas,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: List.generate(
            6,
            (i) => Container(
              alignment: Alignment.center,
              color: Colors.indigo.shade100,
              child: Text('Item ${i + 1}'),
            ),
          ),
        ),
      ),
      // Gire o emulador (ou arraste a borda da janela no desktop/web) e veja o
      // numero de colunas mudar: o didChangeDependencies roda de novo.
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'Largura ${_largura.toStringAsFixed(0)} px -- $_colunas colunas',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
