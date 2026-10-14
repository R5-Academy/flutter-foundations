import 'package:flutter/material.dart';

import 'paginas/pagina_01_resumo_pedido_inchado.dart';
import 'paginas/pagina_02_resumo_pedido.dart';
import 'paginas/pagina_03_funcao_vs_classe.dart';
import 'paginas/pagina_04_prova_rebuild.dart';
import 'paginas/pagina_05_funcao_quebra_animacao.dart';
import 'paginas/pagina_06_produto_inchada.dart';
import 'paginas/pagina_07_produto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Composição de Widgets'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/01': (context) => const PaginaResumoPedidoInchado(),
        '/02': (context) => const PaginaResumoPedido(),
        '/03': (context) => const PaginaFuncaoVsClasse(),
        '/04': (context) => const PaginaProvaRebuild(),
        '/05': (context) => const PaginaFuncaoQuebraAnimacao(),
        '/06': (context) => const PaginaProdutoInchada(),
        '/07': (context) => const PaginaProduto(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Escolha uma página para abrir:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 16),
          _MenuButton(
            label: '01 - Resumo do pedido (inchado)',
            routeName: '/01',
          ),
          _MenuButton(label: '02 - Resumo do pedido', routeName: '/02'),
          _MenuButton(label: '03 - Função vs classe', routeName: '/03'),
          _MenuButton(label: '04 - Prova de rebuild', routeName: '/04'),
          _MenuButton(
            label: '05 - Função que quebra animação',
            routeName: '/05',
          ),
          _MenuButton(label: '06 - Produto inchado', routeName: '/06'),
          _MenuButton(label: '07 - Produto', routeName: '/07'),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.label, required this.routeName});

  final String label;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, routeName),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(label),
        ),
      ),
    );
  }
}
