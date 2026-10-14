// 01_o_primeiro_metodo.dart
// Demonstra: a assinatura do initState e onde ele entra na linha do tempo.
//   Com debugPrint nos tres metodos, o console prova: createState -> initState
//   -> build, com initState rodando 1x e build rodando N vezes.
// Novo em relacao a aula de createState: o metodo initState em si, o
//   super.initState() sempre como primeira linha, e a posicao dele no ciclo.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaContador()));

class TelaContador extends StatefulWidget {
  const TelaContador({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<TelaContador> createState() {
    // O debugPrint aqui e so didatico -- para ver a ordem no console. Na vida
    // real, createState deve ser so a fabrica de uma linha (por isso o lint).
    debugPrint('1) createState  -> criou o objeto State');
    return _TelaContadorState();
  }
}

class _TelaContadorState extends State<TelaContador> {
  int _cliques = 0;

  @override
  void initState() {
    // * super.initState() e SEMPRE a primeira linha. Sem ele, o setup interno
    //   da classe State nao roda e o framework quebra o app com uma assercao.
    super.initState();
    debugPrint('2) initState    -> inicializou o State (roda 1x)');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('3) build        -> desenhou a UI (roda a cada setState)');
    return Scaffold(
      appBar: AppBar(title: const Text('Linha do tempo do State')),
      body: Center(
        child: Text('Cliques: $_cliques', style: const TextStyle(fontSize: 28)),
      ),
      floatingActionButton: FloatingActionButton(
        // ! Clique algumas vezes e olhe o console: createState e initState nao
        //   repetem; so o build volta a rodar. Por isso o estado persiste.
        onPressed: () => setState(() => _cliques++),
        child: const Icon(Icons.add),
      ),
    );
  }
}
