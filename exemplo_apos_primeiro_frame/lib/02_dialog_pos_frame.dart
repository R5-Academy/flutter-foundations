// 02_dialog_pos_frame.dart
// Demonstra: a solucao. O MESMO showDialog do exemplo 01, agora agendado com
//   addPostFrameCallback -- roda depois que o primeiro frame foi desenhado, e
//   por isso funciona.
// Novo em relacao ao 01: WidgetsBinding.instance.addPostFrameCallback((_) {...})
//   dentro do initState. O (_) ignora o timeStamp, que aqui nao interessa.

import 'package:material_ui/material_ui.dart';

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

    // * Agenda o codigo para rodar UMA vez, logo apos o proximo frame. Nesse
    //   ponto a tela ja esta montada: o Overlay existe e showDialog funciona.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Entre agendar e disparar o widget pode ter saido da tela. Se ja saiu,
      // nao ha o que mostrar -- e usar o context seria um erro.
      if (!mounted) return;

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
