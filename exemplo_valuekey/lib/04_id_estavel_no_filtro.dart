// 04_id_estavel_no_filtro.dart
// Demonstra: o caso de uso nº1 da ValueKey no mundo real -- uma lista FILTRAVEL
//   de widgets stateful. Cada contato pode ser "expandido" (mostra o telefone);
//   esse aberto/fechado e' estado interno do tile. Ao digitar na busca, itens
//   somem e reaparecem: sem key, o "expandido" gruda na POSICAO e pula de
//   contato; com ValueKey(contato.id), o estado acompanha o contato certo.
// Vire a constante usarKey para comparar os dois comportamentos ao vivo.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaContatos()));

// * true: ValueKey(contato.id) -> o "expandido" segue o contato.
//   false: sem key -> o "expandido" fica preso na posicao ao filtrar.
const bool usarKey = true;

class Contato {
  const Contato({required this.id, required this.nome, required this.fone});

  final int id;
  final String nome;
  final String fone;
}

class ContatoTile extends StatefulWidget {
  const ContatoTile({super.key, required this.contato});

  final Contato contato;

  @override
  State<ContatoTile> createState() => _ContatoTileState();
}

class _ContatoTileState extends State<ContatoTile> {
  // Estado interno: precisa seguir o contato, nao a posicao na lista.
  bool _expandido = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(child: Text(widget.contato.nome[0])),
          title: Text(widget.contato.nome),
          trailing: Icon(_expandido ? Icons.expand_less : Icons.expand_more),
          onTap: () => setState(() => _expandido = !_expandido),
        ),
        if (_expandido)
          Padding(
            padding: const EdgeInsets.only(left: 72, bottom: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.contato.fone),
            ),
          ),
      ],
    );
  }
}

class TelaContatos extends StatefulWidget {
  const TelaContatos({super.key});

  @override
  State<TelaContatos> createState() => _TelaContatosState();
}

class _TelaContatosState extends State<TelaContatos> {
  static const _todos = [
    Contato(id: 1, nome: 'Ana', fone: '(11) 90000-0001'),
    Contato(id: 2, nome: 'Bruno', fone: '(11) 90000-0002'),
    Contato(id: 3, nome: 'Carla', fone: '(11) 90000-0003'),
    Contato(id: 4, nome: 'Diego', fone: '(11) 90000-0004'),
  ];

  var _busca = '';

  @override
  Widget build(BuildContext context) {
    final filtrados = _todos
        .where((c) => c.nome.toLowerCase().contains(_busca.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(usarKey ? 'Com ValueKey(id)' : 'Sem key')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar contato',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _busca = v),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (final c in filtrados)
                  // * A key vai no topo do item (o ContatoTile) com o id estavel.
                  //   Assim o "expandido" segue o contato ao filtrar/desfiltrar.
                  ContatoTile(key: usarKey ? ValueKey(c.id) : null, contato: c),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
