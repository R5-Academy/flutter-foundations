// exemplo_03_rolar_ate_o_fim.dart
// Demonstra: uso real. Uma tela de "chat" que ja abre rolada no fim da lista,
//   como um app de mensagens. So da para rolar depois que a lista existe.
// Novo em relacao ao 02: usa um ScrollController. No initState ele ainda nao
//   esta ligado a lista (hasClients == false); no pos-frame, sim.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaChat()));

class TelaChat extends StatefulWidget {
  const TelaChat({super.key});

  @override
  State<TelaChat> createState() => _TelaChatState();
}

class _TelaChatState extends State<TelaChat> {
  final ScrollController _controller = ScrollController();

  // Mensagens antigas em cima, recentes embaixo -- como num chat de verdade.
  final List<String> _mensagens = List.generate(
    40,
    (i) => 'Mensagem numero ${i + 1}',
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      if (_controller.hasClients) {
        await Future.delayed(Duration(seconds: 2));
        _controller.jumpTo(_controller.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    // O par do controller: quem cria, descarta. (dispose e a proxima parte do
    // ciclo de vida -- aqui so aplicamos o habito.)
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat (abre no fim)')),
      body: ListView.builder(
        controller: _controller,
        itemCount: _mensagens.length,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.chat_bubble_outline),
          title: Text(_mensagens[index]),
        ),
      ),
    );
  }
}
