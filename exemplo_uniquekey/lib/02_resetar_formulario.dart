// 02_resetar_formulario.dart
// Demonstra: o uso correto da UniqueKey -- forcar a recriacao de um subtree para
//   RESETAR tudo de uma vez. A key vive num CAMPO do State e so e' trocada quando
//   o usuario clica "Resetar". Trocar a key faz o Flutter descartar o Element/State
//   do subtree e recria-lo do zero: initState roda de novo, tudo volta ao inicial.
// Novo em relacao ao 01: aqui a "identidade que nunca casa" vira ferramenta --
//   observe no console o initState do MiniFormulario disparando SO no reset.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaReset()));

class TelaReset extends StatefulWidget {
  const TelaReset({super.key});

  @override
  State<TelaReset> createState() => _TelaResetState();
}

class _TelaResetState extends State<TelaReset> {
  // * A UniqueKey vive aqui, no State -- estavel entre rebuilds comuns.
  //   So trocamos ela quando queremos resetar o formulario inteiro.
  Key _formKey = UniqueKey();

  void _resetar() {
    // Key nova -> o MiniFormulario antigo nao casa mais -> Flutter joga fora o
    // State (dispose) e monta um novo (initState). Campo e contador zeram.
    setState(() => _formKey = UniqueKey());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resetar com UniqueKey')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // O subtree que queremos poder resetar recebe a key do State.
            MiniFormulario(key: _formKey),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _resetar,
              icon: const Icon(Icons.restart_alt),
              label: const Text('Resetar'),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniFormulario extends StatefulWidget {
  const MiniFormulario({super.key});

  @override
  State<MiniFormulario> createState() => _MiniFormularioState();
}

class _MiniFormularioState extends State<MiniFormulario> {
  final _controller = TextEditingController();
  int _contador = 0;

  @override
  void initState() {
    super.initState();
    // Roda de novo a cada troca de key -- prova de que o subtree renasceu.
    debugPrint('MiniFormulario.initState: nasci de novo (estado zerado)');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Digite algo'),
            ),
            const SizedBox(height: 16),
            Text('Contador: $_contador', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => setState(() => _contador++),
              child: const Text('Incrementar'),
            ),
          ],
        ),
      ),
    );
  }
}
