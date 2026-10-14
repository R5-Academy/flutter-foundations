// pagina_05_funcao_quebra_animacao.dart
// Exemplo 05 — a função quebra o AnimatedSwitcher: dois Container (mesmo tipo)
// não animam; classes distintas animam. Animação é assunto de fase futura;
// aqui é só o veículo para VER a diferença. Clique em "Trocar" e compare.

import 'package:material_ui/material_ui.dart';

class PaginaFuncaoQuebraAnimacao extends StatefulWidget {
  const PaginaFuncaoQuebraAnimacao({super.key});

  @override
  State<PaginaFuncaoQuebraAnimacao> createState() =>
      _PaginaFuncaoQuebraAnimacaoState();
}

class _PaginaFuncaoQuebraAnimacaoState
    extends State<PaginaFuncaoQuebraAnimacao> {
  bool primeira = true;

  // FUNÇÃO: as duas retornam Container (mesmo tipo) → o AnimatedSwitcher não
  // distingue "antes" de "depois" e não anima.
  Widget _caixaComoFuncao() {
    return primeira
        ? Container(width: 120, height: 120, color: Colors.red)
        : Container(width: 120, height: 120, color: Colors.blue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Função quebra animação')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('FUNÇÃO (não anima):'),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _caixaComoFuncao(),
            ),
            const SizedBox(height: 32),
            const Text('CLASSE (anima):'),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              // Tipos diferentes → o framework vê uma troca real e anima.
              child: primeira ? const _CaixaVermelha() : const _CaixaAzul(),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => setState(() => primeira = !primeira),
              child: const Text('Trocar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CaixaVermelha extends StatelessWidget {
  const _CaixaVermelha();

  @override
  Widget build(BuildContext context) {
    return Container(width: 120, height: 120, color: Colors.red);
  }
}

class _CaixaAzul extends StatelessWidget {
  const _CaixaAzul();

  @override
  Widget build(BuildContext context) {
    return Container(width: 120, height: 120, color: Colors.blue);
  }
}
