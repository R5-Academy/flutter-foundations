// 05_funcao_quebra_animacao.dart
// PONTO 2 — o caso em que a função não é só "mais lenta": ela QUEBRA.
// Aqui não é performance, é comportamento. Prova cabal de que função e classe
// NÃO são intercambiáveis.
//
// >>> AVISO: AnimatedSwitcher e animações são assunto de uma fase MAIS À FRENTE
//     (Flutter UI Development). Aqui a animação é só o VEÍCULO para você VER a
//     diferença com os próprios olhos — não precisa entender a animação agora,
//     só observar QUEM anima e QUEM não anima. <<<
//
// Como o AnimatedSwitcher decide animar: ele compara o filho novo com o antigo
// pela MESMA regra do framework (mesmo tipo + mesma key = "é o mesmo widget").
// Ele só anima quando enxerga um filho DIFERENTE.
//
//   • Em cima (FUNÇÃO): as duas opções retornam o MESMO tipo (Container). Para o
//     framework é "o mesmo widget, só mudou a cor" → NÃO anima, troca seco.
//   • Embaixo (CLASSE): CaixaVermelha e CaixaAzul são tipos DIFERENTES → o
//     framework vê uma troca de verdade → ANIMA (cross-fade).
//
// Clique no botão e compare: a de cima pisca, a de baixo faz transição suave.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: Scaffold(body: Demo())));

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  bool primeira = true;

  // (a) FUNÇÃO: as duas retornam Container — MESMO tipo. O AnimatedSwitcher não
  //     consegue distinguir "antes" de "depois" → não anima.
  Widget _caixaComoFuncao() {
    return primeira
        ? Container(width: 120, height: 120, color: Colors.red)
        : Container(width: 120, height: 120, color: Colors.blue);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
            // Tipos diferentes (CaixaVermelha x CaixaAzul) → o framework vê uma
            // troca real e faz a transição.
            child: primeira ? const CaixaVermelha() : const CaixaAzul(),
          ),
          const SizedBox(height: 32),

          ElevatedButton(
            onPressed: () => setState(() => primeira = !primeira),
            child: const Text('Trocar'),
          ),
        ],
      ),
    );
  }
}

// Duas CLASSES distintas: cada estado ganha uma IDENTIDADE DE TIPO que o
// framework enxerga. É isso que a função (sempre um Container) não oferece.
class CaixaVermelha extends StatelessWidget {
  const CaixaVermelha({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 120, height: 120, color: Colors.red);
  }
}

class CaixaAzul extends StatelessWidget {
  const CaixaAzul({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 120, height: 120, color: Colors.blue);
  }
}

// REGRA FINAL DA AULA:
// Função e classe não são "a mesma coisa com sintaxe diferente". A classe ganha
// nó próprio na árvore, pode ser const (pula rebuilds), tem context/key próprios,
// anima e debuga direito. A função re-executa sempre e pode quebrar animação e
// estado. NA DÚVIDA, extraia uma CLASSE — a IDE faz num atalho.
