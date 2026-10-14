// 01_a_fabrica.dart
// Demonstra: o que e o createState, lido linha por linha. Ele e uma FABRICA:
//   a unica coisa que faz e criar e devolver o objeto State.
// Ponto de partida da secao Ciclo de Vida: o createState e o marco zero, o
//   momento em que o State nasce.

import 'package:material_ui/material_ui.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(body: Center(child: CardContador())),
    ),
  );
}

// O StatefulWidget e imutavel e recriado a cada build. Ele nao guarda estado;
// ele so descreve a configuracao e aponta quem vai guardar o estado.
class CardContador extends StatefulWidget {
  const CardContador({super.key});

  // * A assinatura, destrinchada:
  //   @override            -> createState e um contrato exigido pelo StatefulWidget.
  //                           Nao estamos inventando um metodo; estamos cumprindo
  //                           a obrigacao. Se errar o nome, o analisador avisa.
  //   State<CardContador>  -> o tipo de retorno. State e generico
  //                           (State<T extends StatefulWidget>); o <CardContador>
  //                           amarra este State a este widget e e o que faz
  //                           `widget.xxx` ja vir tipado la dentro.
  //   => _CardContadorState() -> o corpo e uma fabrica de UMA linha: cria e
  //                           devolve a instancia do State. Nada alem disso.
  @override
  State<CardContador> createState() => _CardContadorState();
}

// O State e mutavel e PERSISTE enquanto este pedaco da tela estiver vivo.
// E aqui que o valor sobrevive de um setState para o outro.
class _CardContadorState extends State<CardContador> {
  int _cliques = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Cliques: $_cliques', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () => setState(() => _cliques++),
              child: const Text('Somar'),
            ),
          ],
        ),
      ),
    );
  }
}
