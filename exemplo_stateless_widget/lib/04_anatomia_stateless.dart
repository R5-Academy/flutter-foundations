// 04_anatomia_stateless.dart
// Demonstra: dissecar o StatelessWidget peça por peça — o que cada parte faz.
// Novo em relação ao 03: aqui o foco não é o resultado na tela, é ENTENDER a
//   assinatura. Por que const? Por que final? Por que super.key? O que é build?
//
// Um StatelessWidget é uma função dos seus dados: UI = f(dados).
// Os dados entram pelo construtor (final) e o build os transforma em widgets.

import 'package:material_ui/material_ui.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          // 'const' na hora de USAR: o Flutter reaproveita esta mesma instância
          // entre rebuilds em vez de criar uma nova. Desempenho de graça.
          child: Saudacao(nome: 'Rodrigo'),
        ),
      ),
    ),
  );
}

class Saudacao extends StatelessWidget {
  // 1) Construtor 'const' -> permite instâncias reaproveitadas em compilação.
  // 2) 'super.key' -> repassa a Key para o Widget; é como o Element reconhece
  //    "é o mesmo widget de antes?" na reconciliação. Sempre inclua.
  const Saudacao({super.key, required this.nome});

  // 3) Campo 'final' -> o widget é IMUTÁVEL. Ele é a "planta de papel": recriada
  //    a cada build, nunca mutada. Estado que muda NÃO mora aqui.
  final String nome;

  // 4) build() -> o ÚNICO método que você escreve. Recebe o BuildContext (a
  //    posição na árvore) e RETORNA outros widgets. Deve ser PURO e RÁPIDO:
  //    mesmos dados -> mesma UI, sem efeitos colaterais (nada de rede/IO aqui).
  @override
  Widget build(BuildContext context) {
    return Text('Olá, $nome!', style: const TextStyle(fontSize: 24));
  }
}
