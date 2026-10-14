// 04_a_prova_rebuild.dart
// PONTO 2 — A PROVA VIVA de que função e classe NÃO são a mesma coisa.
// Um contador de rebuilds: um print() dentro de cada build. O pai é um
// StatefulWidget com um botão que chama setState. Ele mostra dois filhos:
// um feito por FUNÇÃO, outro por CLASSE const.
//
// >>> RODE e clique no botão várias vezes olhando o CONSOLE (debug console). <<<
//
// O que você vai ver a cada clique:
//   🏠 build do PAI        → aparece SEMPRE (foi quem chamou setState).
//   🔁 FUNÇÃO reconstruiu   → aparece SEMPRE junto — a função re-executa.
//   🟢 CLASSE const         → aparece só na 1ª vez. Depois: SILÊNCIO.
//
// Por quê? A `const FilhoViaClasse()` é a MESMA instância a cada frame; o
// Flutter reconhece a identidade e faz "short-circuit": pula o build dela.
// A função não tem instância const nem nó próprio na árvore — re-executa sempre.
//
// EXPERIMENTO: tire o `const` de `const FilhoViaClasse()`. Ela volta a
// reconstruir a cada clique — provando que o ganho vem da dupla CLASSE + const,
// e que a função NUNCA consegue ser const.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: Demo()));

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  int contador = 0;

  // (a) FILHO COMO FUNÇÃO: re-executa a cada build do pai.
  Widget _filhoViaFuncao() {
    debugPrint('🔁 FUNÇÃO reconstruiu');
    return const Text('Sou uma função');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🏠 build do PAI (contador = $contador)');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contador: $contador'), // este SIM precisa mudar
            _filhoViaFuncao(), // reconstrói sempre
            const FilhoViaClasse(), // const → é PULADO nos próximos setState
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

// (b) FILHO COMO CLASSE const: o build roda UMA vez e depois é pulado.
class FilhoViaClasse extends StatelessWidget {
  const FilhoViaClasse({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🟢 CLASSE const reconstruiu'); // só na 1ª vez!
    return const Text('Sou uma classe');
  }
}
