// 01_o_problema_tamanho_fixo.dart
// Demonstra: a DOR que o MediaQuery resolve. Uma caixa com largura CRAVADA em
//   350 pixels. No seu emulador ela pode caber; numa tela mais estreita ela
//   estoura e o Flutter pinta a faixa listrada de overflow.
//
// ! O widget nao faz ideia do tamanho da tela onde ele caiu. Ele so obedece:
// ! "eu tenho 350 de largura", custe o que custar.
//
// Rode e, no navegador/desktop, ARRASTE a janela para bem estreita (ou rode num
// aparelho pequeno): a caixa nao encolhe junto — ela vaza. Pergunta:
// como o widget PERGUNTA quanto espaco a tela tem? Resposta: MediaQuery (02).

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppTamanhoFixo());

class AppTamanhoFixo extends StatelessWidget {
  const AppTamanhoFixo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tamanho fixo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Banner da promocao')),
        body: Center(
          child: Container(
            // ! O problema esta AQUI: largura cravada, sem olhar para a tela.
            width: 350,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Frete gratis hoje!',
              style: TextStyle(color: Colors.white, fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
