// 03_valor_duplicado.dart
// Demonstra: a armadilha nº2 na escolha do valor -- valor NAO-unico entre os
//   irmaos. Como a ValueKey compara por valor, dois irmaos com o mesmo valor
//   viram duas keys IGUAIS. O Flutter nao consegue distinguir quem e' quem e
//   lanca "Multiple widgets used the same key" em runtime.
// Aqui ha' duas pessoas chamadas "Ana". Vire a constante usarNome para true e
//   rode: usar ValueKey(pessoa.nome) crasha. Deixe false para ver a versao
//   correta com ValueKey(pessoa.id).

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaPessoas()));

// ! true: usa o NOME como key. Como ha' dois "Ana", as keys colidem e o app
//   crasha com "Multiple widgets used the same key". Deixe false p/ ver o certo.
const bool usarNome = false;

class Pessoa {
  const Pessoa({required this.id, required this.nome});

  final int id;
  final String nome;
}

class TelaPessoas extends StatelessWidget {
  const TelaPessoas({super.key});

  // Note os DOIS "Ana": o nome nao serve de identidade, mas o id sim.
  static const _pessoas = [
    Pessoa(id: 1, nome: 'Ana'),
    Pessoa(id: 2, nome: 'Bruno'),
    Pessoa(id: 3, nome: 'Ana'),
    Pessoa(id: 4, nome: 'Carla'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(usarNome ? 'ValueKey(nome) - quebra' : 'ValueKey(id) - ok'),
      ),
      body: ListView(
        children: [
          for (final p in _pessoas)
            ListTile(
              // ! ValueKey(p.nome): dois "Ana" -> mesma key -> crash.
              // * ValueKey(p.id): id e' unico -> cada tile tem identidade propria.
              key: usarNome ? ValueKey(p.nome) : ValueKey(p.id),
              leading: CircleAvatar(child: Text(p.nome[0])),
              title: Text(p.nome),
              subtitle: Text('id ${p.id}'),
            ),
        ],
      ),
    );
  }
}

// ? E quando o item NAO tem um valor unico simples -- nem id, e o nome repete?
//   Forcar um ValueKey nao resolve. A resposta e' identificar o OBJETO em si
//   (por referencia), e' a ObjectKey -- assunto da proxima aula.
