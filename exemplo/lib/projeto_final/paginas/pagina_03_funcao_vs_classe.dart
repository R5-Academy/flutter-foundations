// pagina_03_funcao_vs_classe.dart
// Exemplo 03 — as duas formas lado a lado: cabeçalho como FUNÇÃO x como CLASSE.
// A classe demonstrativa é privada deste arquivo (é artefato do demo, não um
// widget reutilizável do app).

import 'package:material_ui/material_ui.dart';

class PaginaFuncaoVsClasse extends StatelessWidget {
  const PaginaFuncaoVsClasse({super.key});

  // (a) FORMA FUNÇÃO: uma chamada — não pode ser const, executa toda vez.
  Widget _cabecalhoComoFuncao(String titulo) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(titulo, style: const TextStyle(fontSize: 18)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Função x Classe')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _cabecalhoComoFuncao('Feito com FUNÇÃO'),
            const _CabecalhoComoClasse('Feito com CLASSE'),
          ],
        ),
      ),
    );
  }
}

// (b) FORMA CLASSE: nó próprio na árvore, pode ser const.
class _CabecalhoComoClasse extends StatelessWidget {
  const _CabecalhoComoClasse(this.titulo);

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(titulo, style: const TextStyle(fontSize: 18)),
    );
  }
}
