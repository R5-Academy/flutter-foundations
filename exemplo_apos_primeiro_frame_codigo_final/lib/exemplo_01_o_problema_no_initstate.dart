// exemplo_01_o_problema_no_initstate.dart
// Demonstra: por que o initState e cedo demais para acoes que dependem da tela
//   montada. Tentar abrir um showDialog direto no initState QUEBRA o app.
// Novo em relacao a aula de initState: aqui o objetivo e ver o erro acontecer
//   ao vivo -- ele e o gancho para a solucao (addPostFrameCallback).

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

    // ! ERRADO: no initState a tela ainda NAO foi desenhada. Nao existe o
    //   Overlay onde o dialogo aparece, e showDialog precisa achar o Navigator
    //   pela arvore (dependOnInheritedWidgetOfExactType) -- o que e proibido
    //   aqui. Rode e veja a excecao no console:
    //     "dependOnInheritedWidgetOfExactType<...>() was called before
    //      _TelaBoasVindasState.initState() completed."
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Bem-vindo!'),
        content: Text('Este dialogo tenta abrir cedo demais.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Boas-vindas (com bug)')),
      body: const Center(
        child: Text('Se voce esta lendo isto, o console ja acusou o erro.'),
      ),
    );
  }
}
