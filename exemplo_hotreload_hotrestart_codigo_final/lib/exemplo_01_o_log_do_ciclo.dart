// exemplo_01_o_log_do_ciclo.dart
// Demonstra: quais metodos do ciclo de vida rodam no Hot Reload e no Hot Restart.
//   A tela imprime createState, initState, didChangeDependencies, reassemble,
//   didUpdateWidget, build e dispose. Rode e observe o console:
//   - Hot Reload (r): NAO chama initState de novo; roda reassemble + build.
//   - Hot Restart (R): recomeca do main -> createState + initState + build.
// Este e o exemplo-ancora da aula: liga Reload/Restart ao ciclo de vida que o
// aluno acabou de aprender.

import 'package:flutter/material.dart';

void main() => runApp(const App());

// App e Stateless. No Hot Reload o framework reconstroi a arvore inteira, entao
// este build roda de novo e cria um NOVO TelaCiclo -> o State (preservado)
// recebe didUpdateWidget. E o gancho para o aluno ver o didUpdateWidget disparar
// no reload sem o initState rodar.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TelaCiclo());
  }
}

class TelaCiclo extends StatefulWidget {
  const TelaCiclo({super.key});

  // createState roda logo antes do initState, tanto no primeiro run quanto no
  // Hot Restart. Sem logica aqui (a turma ja viu essa regra): o log fica no
  // initState, que roda na mesma hora.
  @override
  State<TelaCiclo> createState() => _TelaCicloState();
}

class _TelaCicloState extends State<TelaCiclo> {
  int _contador = 0;

  @override
  void initState() {
    super.initState();
    // * initState roda UMA vez na vida do objeto State. No Hot Reload ele NAO
    //   roda de novo (o State e preservado); no Hot Restart, sim (State novo).
    debugPrint('initState   -> uma vez por State (some no Hot Reload)');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('didChangeDependencies');
  }

  @override
  void reassemble() {
    super.reassemble();
    // * reassemble e o gancho EXCLUSIVO de desenvolvimento: o framework o chama
    //   em cada State durante o Hot Reload. Nao existe em release.
    debugPrint('reassemble  -> so no Hot Reload (ferramenta de dev)');
  }

  @override
  void didUpdateWidget(covariant TelaCiclo oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Roda quando o pai reconstroi e entrega um novo widget do mesmo tipo. No
    // Hot Reload isso acontece porque a arvore inteira reconstroi.
    debugPrint('didUpdateWidget -> pai reconstruiu, State preservado');
  }

  @override
  void dispose() {
    // No Hot Reload nao ha dispose (o State continua vivo). No Hot Restart o app
    // apenas reinicia e descarta o estado antigo: nao conte com um dispose
    // ordenado aqui.
    debugPrint('dispose     -> saida definitiva da arvore');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build       -> roda no Reload E no Restart');
    return Scaffold(
      appBar: AppBar(title: const Text('O log do ciclo de vida')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Deixe o console a vista e observe o que roda x:'),
            const SizedBox(height: 16),
            // O contador e o "estado". Suba alguns cliques, depois de um Reload
            // (o numero fica) e um Restart (o numero zera).
            Text(
              '$_contador',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _contador++),
        child: const Icon(Icons.add),
      ),
    );
  }
}
