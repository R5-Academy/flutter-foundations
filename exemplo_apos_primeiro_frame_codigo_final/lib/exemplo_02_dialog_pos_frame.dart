// exemplo_02_dialog_pos_frame.dart
// Demonstra: a solucao. O MESMO showDialog do exemplo 01, agora agendado com
//   addPostFrameCallback -- roda depois que o primeiro frame foi desenhado, e
//   por isso funciona.
// Novo em relacao ao 01: WidgetsBinding.instance.addPostFrameCallback((_) {...})
//   dentro do initState. O (_) ignora o timeStamp, que aqui nao interessa.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaBoasVindas()));

class TelaBoasVindas extends StatefulWidget {
  const TelaBoasVindas({super.key});

  @override
  State<TelaBoasVindas> createState() => _TelaBoasVindasState();
}

class _TelaBoasVindasState extends State<TelaBoasVindas> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Bem-vindo!'),
          content: const Text('Agora o dialogo abre na hora certa.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Entendi'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Boas-vindas')),
      body: const Center(
        child: Text('A tela abre e o pop-up aparece sozinho.'),
      ),
    );
  }
}
