// exemplo_04_carregar_dados_async.dart
// Demonstra: disparar a carga inicial de dados no initState. A tela abre em
//   estado "carregando", busca os dados e depois se reconstroi com o resultado.
// Novo em relacao ao 03: o initState NAO pode ser async. Ele chama um metodo
//   async separado e segue em frente; a guarda `if (!mounted) return;` (ja vista
//   em Erros Comuns) protege o setState depois do await.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaPerfil()));

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  String? _nome;
  var _carregando = true;

  @override
  void initState() {
    super.initState();
    // * initState nao pode ser `async` -- sua assinatura e `void`. Entao ele
    //   apenas DISPARA o metodo async e segue; o build roda logo, mostrando o
    //   estado "carregando" enquanto os dados nao chegam.
    _carregarPerfil();
  }

  Future<void> _carregarPerfil() async {
    // Simula uma busca em API/banco.
    final nome = await _buscarNomeNoServidor();

    // ! Depois de um await, o widget pode ter saido da tela. Sem esta guarda,
    //   o setState estouraria erro por rodar num State ja desmontado.
    if (!mounted) return;

    setState(() {
      _nome = nome;
      _carregando = false;
    });
  }

  Future<String> _buscarNomeNoServidor() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Ana Souza';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Center(
        child: _carregando
            ? const CircularProgressIndicator()
            : Text('Ola, $_nome!', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
