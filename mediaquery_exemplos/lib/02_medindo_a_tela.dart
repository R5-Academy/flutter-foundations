// 02_medindo_a_tela.dart
// Demonstra: a SOLUCAO do 01. Agora o widget PERGUNTA a tela com
//   MediaQuery.of(context), que devolve um MediaQueryData com tudo sobre o
//   dispositivo: tamanho, orientacao, densidade de pixels, etc.
//
// * MediaQuery.of(context) e o MESMO padrao do Theme.of(context) que voce viu na
// * aula passada: um dado que vem "de cima" pela arvore. O MaterialData insere o
// * MediaQuery la no topo; aqui embaixo a gente le.
//
// Duas coisas para ver ao vivo:
//   1) O card de diagnostico mostra os numeros REAIS da tela. Arraste a janela
//      (desktop/web) e veja largura/altura/orientacao mudarem na hora.
//   2) A caixa do banner agora usa size.width * 0.8 — ela ACOMPANHA a tela em vez
//      de cravar 350. Fim do overflow do exemplo 01.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppMedindoTela());

class AppMedindoTela extends StatelessWidget {
  const AppMedindoTela({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medindo a tela',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Conhecendo a tela')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardDiagnostico(),
              SizedBox(height: 24),
              BannerProporcional(),
            ],
          ),
        ),
      ),
    );
  }
}

// Le o MediaQueryData inteiro e mostra os principais campos na tela.
class CardDiagnostico extends StatelessWidget {
  const CardDiagnostico({super.key});

  @override
  Widget build(BuildContext context) {
    // Pega o objeto inteiro com os dados da tela.
    final media = MediaQuery.of(context);

    final largura = media.size.width;
    final altura = media.size.height;
    final orientacao = media.orientation; // portrait ou landscape
    final densidade = media.devicePixelRatio; // pixels fisicos por pixel logico

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Raio-x da tela', style: TextStyle(fontSize: 18)),
            const Divider(),
            // toStringAsFixed(0) so para nao mostrar um monte de casas decimais.
            Text('Largura: ${largura.toStringAsFixed(0)} px logicos'),
            Text('Altura:  ${altura.toStringAsFixed(0)} px logicos'),
            Text('Orientacao: ${orientacao.name}'),
            Text('Densidade (devicePixelRatio): $densidade'),
          ],
        ),
      ),
    );
  }
}

// A caixa do exemplo 01, agora proporcional a largura da tela.
class BannerProporcional extends StatelessWidget {
  const BannerProporcional({super.key});

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;

    return Container(
      // 80% da largura da tela, seja ela qual for. Sem overflow.
      width: largura * 0.8,
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
    );
  }
}
