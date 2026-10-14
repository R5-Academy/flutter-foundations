// 06_armadilha_contador.dart
// Demonstra: o erro clássico — tentar guardar estado num StatelessWidget.
// Novo em relação ao 05: mostra o que NÃO funciona e explica por quê, abrindo
//   a porta para a próxima aula (StatefulWidget).
//
// Rode e clique no botão: o número NÃO muda. Este arquivo serve para você
// reconhecer o sintoma "meu contador não conta".

import 'package:material_ui/material_ui.dart';

void main() => runApp(MaterialApp(home: Scaffold(body: Contador())));

class Contador extends StatelessWidget {
  Contador({super.key});

  // ARMADILHA: este campo é a "tentativa de estado". Mesmo sem 'final', ele NÃO
  // funciona como memória. Por quê? Porque a cada rebuild o Flutter cria um
  // Contador NOVO (o widget é jogado fora e recriado), e o valor volta a 0.
  // O que persiste na árvore é o ELEMENT — e o StatelessElement não guarda
  // estado do usuário. Logo, não há onde o _cliques sobreviver.
  //
  // (Repare que o dart até deixa declarar o campo mutável — mas o resultado
  // em tela é sempre 0. O problema não é de sintaxe, é de ARQUITETURA.)
  int cliques = 0; // ❌ não persiste

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Cliques: $cliques', style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          ElevatedButton(
            // Incrementar aqui não redesenha nada: StatelessWidget não tem como
            // pedir um rebuild de si mesmo (não existe setState). E, mesmo que
            // redesenhasse, viria um Contador novo com _cliques = 0.
            onPressed: () => cliques++, // ❌ muda o campo, mas a tela não reage
            child: const Text('Somar'),
          ),
        ],
      ),
    );
  }
}

// CORREÇÃO (spoiler da próxima aula): quando é preciso guardar e MUDAR um estado
// interno que redesenha a tela, o estado tem que viver preso ao Element, num
// objeto State — e é isso que o StatefulWidget + setState resolvem. Fica para a
// próxima aula.
