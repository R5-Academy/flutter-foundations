// exemplo_04_escolha_id_ou_objeto.dart
// Demonstra: o criterio de escolha na pratica. Itens de carrinho criados no
//   cliente ainda NAO tem id do servidor -- enquanto isso, ObjectKey(item)
//   identifica cada um pela instancia. Quando o backend devolve o id, o certo e'
//   migrar para ValueKey(item.id), que sobrevive ate a recriacao do objeto.
// Novo em relacao ao 03: fecha a decisao "tem id -> ValueKey; nao tem, mas tem
//   o objeto estavel -> ObjectKey" num fluxo com cara de app.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaCarrinho()));

// Item que nasce SEM id (id == null) e pode ganhar um id do servidor depois.
class ItemCarrinho {
  ItemCarrinho({this.id, required this.nome});

  final int? id;
  final String nome;
}

class QuantidadeTile extends StatefulWidget {
  const QuantidadeTile({super.key, required this.item});

  final ItemCarrinho item;

  @override
  State<QuantidadeTile> createState() => _QuantidadeTileState();
}

class _QuantidadeTileState extends State<QuantidadeTile> {
  // A quantidade e' o estado local do tile -- tem que seguir o item certo
  // quando a lista reordena.
  int _qtd = 1;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        title: Text(item.nome),
        subtitle: Text(item.id == null ? 'sem id (local)' : 'id ${item.id}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => setState(() => _qtd = (_qtd - 1).clamp(1, 99)),
              icon: const Icon(Icons.remove),
            ),
            Text('$_qtd', style: const TextStyle(fontSize: 18)),
            IconButton(
              onPressed: () => setState(() => _qtd++),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaCarrinho extends StatefulWidget {
  const TelaCarrinho({super.key});

  @override
  State<TelaCarrinho> createState() => _TelaCarrinhoState();
}

class _TelaCarrinhoState extends State<TelaCarrinho> {
  // Instancias estaveis no State. Comecam sem id (adicionadas no app).
  final List<ItemCarrinho> _itens = [
    ItemCarrinho(nome: 'Camiseta'),
    ItemCarrinho(nome: 'Caneca'),
    ItemCarrinho(nome: 'Adesivo'),
  ];

  // Escolha da key: se o item ja tem id, usamos ValueKey(id) -- resistente ate a
  // recriacao do objeto. Enquanto nao tem, ObjectKey(item) segura a identidade
  // pela instancia (estavel porque a lista vive aqui no State).
  Key _keyDoItem(ItemCarrinho item) =>
      item.id != null ? ValueKey(item.id) : ObjectKey(item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho: id -> ValueKey; sem id -> ObjectKey')),
      body: ListView(
        children: [
          for (final item in _itens)
            QuantidadeTile(key: _keyDoItem(item), item: item),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(_itens.shuffle),
        icon: const Icon(Icons.shuffle),
        label: const Text('Reordenar'),
      ),
    );
  }
}
