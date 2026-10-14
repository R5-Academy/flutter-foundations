// exemplo_04_o_caso_do_controller.dart
// Demonstra: o uso mais real do didUpdateWidget. Um AnimationController recebe a
//   duration de uma prop. Criado UMA vez no initState; quando o pai muda a
//   duration, resincronizamos no didUpdateWidget -- com o if para nao mexer no
//   controller a toa.
// Novo em relacao aos anteriores: agora o "estado derivado da prop" e um
//   recurso vivo (o controller), nao um int. Sem resincronizar, a animacao
//   ignoraria a duracao nova.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaPai()));

class TelaPai extends StatefulWidget {
  const TelaPai({super.key});

  @override
  State<TelaPai> createState() => _TelaPaiState();
}

class _TelaPaiState extends State<TelaPai> {
  // A velocidade do pulso vem daqui e desce como prop para o filho.
  Duration _duracao = const Duration(milliseconds: 1500);
  String nome = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O caso do controller')),
      body: Center(
        child: Column(
          children: [
            Text(nome),
            Pulsante(duracao: _duracao),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  nome = 'Rodrigo Rahman';
                });
              },
              child: Text('Alterando nome'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            // Alterna entre lento e rapido a cada clique.
            _duracao = _duracao.inMilliseconds == 1500
                ? const Duration(milliseconds: 400)
                : const Duration(milliseconds: 1500);
          });
        },
        label: const Text('Trocar velocidade'),
        icon: const Icon(Icons.speed),
      ),
    );
  }
}

class Pulsante extends StatefulWidget {
  const Pulsante({super.key, required this.duracao});

  final Duration duracao;

  @override
  State<Pulsante> createState() => _PulsanteState();
}

class _PulsanteState extends State<Pulsante>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Criado UMA vez, com a duracao inicial vinda da prop.
    _controller = AnimationController(vsync: this, duration: widget.duracao)
      ..repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant Pulsante oldWidget) {
    super.didUpdateWidget(oldWidget);
    // * So reajusta se a duracao realmente mudou. Note que a gente ATUALIZA o
    //   controller existente -- nao cria um novo. Recriar reiniciaria a
    //   animacao (e vazaria o antigo se esquecer o dispose).
    if (oldWidget.duracao != widget.duracao) {
      _controller.duration = widget.duracao;
      // Reinicia o ciclo ja com a nova duracao valendo.
      _controller.repeat(reverse: true);
      debugPrint('duracao atualizada para ${widget.duracao.inMilliseconds}ms');
    }
  }

  @override
  void dispose() {
    // O controller e um recurso: liberado na saida (assunto da proxima aula).
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeTransition(
          opacity: _controller,
          child: const FlutterLogo(size: 120),
        ),
        const SizedBox(height: 16),
        Text('Duracao atual: ${widget.duracao.inMilliseconds}ms'),
      ],
    );
  }
}
