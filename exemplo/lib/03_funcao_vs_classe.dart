// 03_funcao_vs_classe.dart
// PONTO 2 — a pergunta central da aula: ao quebrar um build, há DUAS formas.
//   (a) uma FUNÇÃO/método que retorna Widget  → _cabecalhoComoFuncao()
//   (b) uma CLASSE (StatelessWidget)          → const CabecalhoComoClasse()
//
// Este arquivo mostra as duas LADO A LADO. A tela desenhada é IDÊNTICA — e é
// justamente por parecerem iguais que a confusão nasce. Nos próximos arquivos
// (04 e 05) provamos que NÃO são a mesma coisa.
//
// Repare já numa diferença que salta aos olhos: a forma (b) pôde ser chamada
// com `const`; a forma (a), NUNCA — uma chamada de função não pode ser const.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: Scaffold(body: Tela())));

class Tela extends StatelessWidget {
  const Tela({super.key});

  // (a) FORMA FUNÇÃO: um método que retorna Widget. Note que NÃO dá para
  //     escrever `const _cabecalhoComoFuncao(...)` — é uma chamada, executa
  //     toda vez.
  Widget _cabecalhoComoFuncao(String titulo) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(titulo, style: const TextStyle(fontSize: 18)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Forma (a): chamada de função — sem const.
          _cabecalhoComoFuncao('Feito com FUNÇÃO'),

          // Forma (b): instância de widget-classe — COM const.
          const CabecalhoComoClasse('Feito com CLASSE'),
        ],
      ),
    );
  }
}

// (b) FORMA CLASSE: um StatelessWidget de verdade. Vira um nó próprio na árvore,
//     pode ser `const`, tem key e BuildContext próprios. É a forma recomendada.
class CabecalhoComoClasse extends StatelessWidget {
  const CabecalhoComoClasse(this.titulo, {super.key});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(titulo, style: const TextStyle(fontSize: 18)),
    );
  }
}
