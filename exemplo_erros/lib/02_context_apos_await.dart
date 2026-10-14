// 02_context_apos_await.dart
// Erro comum #2: usar o context no MOMENTO errado (tarde demais).
// Todo `await` e uma porta de saida: enquanto o codigo espera, o usuario pode
//   ter fechado a tela e o widget pode ter saido da arvore (ficado "desmontado").
//   Usar o context (ou chamar setState) depois disso estoura:
//   setState() called after dispose().
// A guarda certa vem LOGO DEPOIS do await: if (!mounted) return;
//
// Como demonstrar sem sair de tela: o botao "Remover card" tira o
//   _CardAssincrono da arvore. Toque "Carregar", e antes dos 2s toque
//   "Remover card": o botao SEM guarda tenta usar um widget que ja morreu.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppAsync());

class AppAsync extends StatelessWidget {
  const AppAsync({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TelaAsync());
  }
}

class TelaAsync extends StatefulWidget {
  const TelaAsync({super.key});

  @override
  State<TelaAsync> createState() => _TelaAsyncState();
}

class _TelaAsyncState extends State<TelaAsync> {
  bool _mostraCard = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erro #2: context depois do await')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_mostraCard)
              const _CardAssincrono()
            else
              const Text('Card removido'),
            const SizedBox(height: 24),
            // Remove o card da arvore: e o que "desmonta" o widget assincrono.
            OutlinedButton(
              onPressed: () => setState(() => _mostraCard = !_mostraCard),
              child: Text(
                _mostraCard ? 'Remover card' : 'Trazer card de volta',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardAssincrono extends StatefulWidget {
  const _CardAssincrono();

  @override
  State<_CardAssincrono> createState() => _CardAssincronoState();
}

class _CardAssincronoState extends State<_CardAssincrono> {
  var _texto = 'Nada carregado ainda';

  // ! VERSAO PERIGOSA: sem guarda. Se o card sair da arvore durante os 2s,
  // ! o setState roda num State ja "defunct" -> setState() called after dispose().
  // ! O analisador ja avisa aqui com o lint use_build_context_synchronously.
  Future<void> _carregarSemGuarda() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _texto = 'Carregado (sem guarda)');
  }

  // * VERSAO SEGURA: a guarda vem LOGO depois do await e antes de tocar o State.
  // * Se o widget morreu durante a espera, a gente simplesmente sai.
  Future<void> _carregarComGuarda() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return; // * State.mounted: o State ainda esta na arvore?
    setState(() => _texto = 'Carregado (com guarda)');

    // Para um context "avulso" (parametro de funcao, StatelessWidget), a versao
    // equivalente e context.mounted (Flutter 3.7+). Aqui, dentro do State, o
    // mounted acima ja garante o uso seguro do context abaixo.
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Feito com seguranca!')));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_texto),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _carregarSemGuarda,
              child: const Text('Carregar SEM guarda (2s)'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _carregarComGuarda,
              child: const Text('Carregar COM guarda (2s)'),
            ),
          ],
        ),
      ),
    );
  }
}
