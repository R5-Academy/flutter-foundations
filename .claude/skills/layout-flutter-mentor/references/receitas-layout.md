# Receitas de layout — padrões comuns prontos

Padrões que aparecem o tempo todo. Use como ponto de partida e adapte. Todo
código segue a convenção do repo (sem emoji, Better Comments, português nos
comentários). Ao usar uma receita, ainda assim **explique o porquê** na resposta
— a receita é o código, não substitui o ensino.

## Box com fundo e cantos arredondados

```dart
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: const Color(0xFFF5F5F5),
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Text('Conteúdo'),
)
```

Com borda e sombra:

```dart
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: const Color(0xFFE0E0E0)),
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
    ],
  ),
  child: const Text('Conteúdo'),
)
```

## Card do Material (elevação de graça)

```dart
Card(
  elevation: 2,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Título', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Descrição do card.'),
      ],
    ),
  ),
)
```

## Linha com item empurrado pra direita

```dart
Row(
  children: [
    const Text('Título'),
    // * Spacer empurra o que vem depois pro fim da linha
    const Spacer(),
    IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
  ],
)
```

## Duas colunas dividindo o espaço (proporção)

```dart
Row(
  children: [
    Expanded(flex: 2, child: Container(color: Colors.blue, height: 100)),
    const SizedBox(width: 8),
    Expanded(flex: 1, child: Container(color: Colors.green, height: 100)),
  ],
)
```

## Tela base com Scaffold

```dart
Scaffold(
  appBar: AppBar(title: const Text('Título')),
  body: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Conteúdo da tela'),
        ],
      ),
    ),
  ),
)
```

## Lista dinâmica (lazy)

```dart
ListView.separated(
  itemCount: itens.length,
  separatorBuilder: (context, index) => const Divider(),
  itemBuilder: (context, index) {
    final item = itens[index];
    return ListTile(
      leading: const Icon(Icons.label),
      title: Text(item.titulo),
      subtitle: Text(item.subtitulo),
    );
  },
)
```

## Grade responsiva

```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    // * maxCrossAxisExtent deixa a grade responsiva: o Flutter calcula
    //   quantas colunas cabem em vez de fixar um número
    maxCrossAxisExtent: 180,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    childAspectRatio: 3 / 4,
  ),
  itemCount: produtos.length,
  itemBuilder: (context, index) => ProdutoCard(produto: produtos[index]),
)
```

## Conteúdo centralizado na tela

```dart
Center(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      FlutterLogo(size: 96),
      SizedBox(height: 16),
      Text('Bem-vindo'),
    ],
  ),
)
```

## Imagem recortada em cantos arredondados

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Image.network(url, height: 160, width: double.infinity, fit: BoxFit.cover),
)
```

## Badge sobreposto (Stack)

```dart
Stack(
  clipBehavior: Clip.none,
  children: [
    const CircleAvatar(radius: 24, child: Icon(Icons.person)),
    Positioned(
      right: -2,
      top: -2,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 10)),
      ),
    ),
  ],
)
```

## Layout que muda com o tamanho da tela (breakpoint)

```dart
LayoutBuilder(
  builder: (context, constraints) {
    // * acima de 600 de largura, mostra lado a lado; abaixo, empilhado
    if (constraints.maxWidth >= 600) {
      return Row(
        children: [
          Expanded(child: _Painel()),
          Expanded(child: _Detalhe()),
        ],
      );
    }
    return Column(
      children: [
        _Painel(),
        _Detalhe(),
      ],
    );
  },
)
```

## Chips que quebram linha (Wrap)

```dart
Wrap(
  spacing: 8,
  runSpacing: 8,
  children: const [
    Chip(label: Text('Dart')),
    Chip(label: Text('Flutter')),
    Chip(label: Text('Firebase')),
  ],
)
```
