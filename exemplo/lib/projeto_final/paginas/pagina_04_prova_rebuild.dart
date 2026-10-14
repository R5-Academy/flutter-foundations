// pagina_04_prova_rebuild.dart
// Exemplo 04 — a prova do rebuild. Abra o console e clique no botão: a função
// reconstrói a cada clique; a classe const só na 1ª vez (short-circuit).

import 'package:material_ui/material_ui.dart';

class PaginaProvaRebuild extends StatefulWidget {
  const PaginaProvaRebuild({super.key});

  @override
  State<PaginaProvaRebuild> createState() => _PaginaProvaRebuildState();
}

class _PaginaProvaRebuildState extends State<PaginaProvaRebuild> {
  int contador = 0;

  // FILHO COMO FUNÇÃO: re-executa a cada build da página.
  Widget _filhoViaFuncao() {
    debugPrint('🔁 FUNÇÃO reconstruiu');
    return const Text('Sou uma função');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🏠 build da PÁGINA (contador = $contador)');
    return Scaffold(
      appBar: AppBar(title: const Text('Prova do rebuild')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contador: $contador'),
            _filhoViaFuncao(), // reconstrói sempre
            const _FilhoViaClasse(), // const → pulado nos próximos setState
            ElevatedButton(
              onPressed: () => setState(() => contador++),
              child: const Text('Incrementar'),
            ),
          ],
        ),
      ),
    );
  }
}

// FILHO COMO CLASSE const: build roda uma vez e depois é pulado.
class _FilhoViaClasse extends StatelessWidget {
  const _FilhoViaClasse();

  @override
  Widget build(BuildContext context) {
    debugPrint('🟢 CLASSE const reconstruiu');
    return const Text('Sou uma classe');
  }
}
