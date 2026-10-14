// exemplo_04_globalkey_reparent.dart
// Demonstra: o superpoder (b) da GlobalKey -- mover uma subárvore de pai sem
//   perder o State (reparent). Um quadrado sorteia a cor no nascimento do State;
//   um botão o troca de lado. Com a chave LIGADA, a cor viaja junto; DESLIGADA,
//   é re-sorteada a cada troca.
// Novo em relação ao 03: agora a GlobalKey não lê o State -- ela PRESERVA o
//   State ao mudar o widget de posição. Liga direto no "o State mora no Element".

import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ReparentDemo()));

class ReparentDemo extends StatefulWidget {
  const ReparentDemo({super.key});

  @override
  State<ReparentDemo> createState() => _ReparentDemoState();
}

class _ReparentDemoState extends State<ReparentDemo> {
  // * A GlobalKey nasce aqui e vive enquanto a tela viver. Estável entre builds.
  final GlobalKey _key = GlobalKey();

  bool naEsquerda = true;
  bool usarKey = true;

  @override
  Widget build(BuildContext context) {
    // O MESMO widget, plugado ora num pai, ora no outro. Quando usarKey é true,
    // ele leva a GlobalKey; quando false, vai sem key nenhuma.
    final quadrado = QuadradoColorido(key: usarKey ? _key : null);

    return Scaffold(
      appBar: AppBar(title: const Text('GlobalKey: reparent preserva o State')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Caixa(child: naEsquerda ? quadrado : null),
              const SizedBox(width: 24),
              _Caixa(child: naEsquerda ? null : quadrado),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => setState(() => naEsquerda = !naEsquerda),
            child: const Text('Trocar de lado'),
          ),
          SwitchListTile(
            title: Text(usarKey ? 'Com GlobalKey' : 'Sem key'),
            subtitle: Text(
              usarKey
                  ? 'A cor sobrevive à troca -- mesmo Element'
                  : 'A cor muda a cada troca -- Element novo, initState de novo',
            ),
            value: usarKey,
            onChanged: (v) => setState(() => usarKey = v),
          ),
        ],
      ),
    );
  }
}

class _Caixa extends StatelessWidget {
  const _Caixa({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      color: Colors.grey.shade300,
      alignment: Alignment.center,
      child: child,
    );
  }
}

class QuadradoColorido extends StatefulWidget {
  const QuadradoColorido({super.key});

  @override
  State<QuadradoColorido> createState() => _QuadradoColoridoState();
}

class _QuadradoColoridoState extends State<QuadradoColorido> {
  // A cor é sorteada UMA vez, no nascimento do State. Se ela mudar ao trocar de
  // lado, foi porque o State morreu e renasceu (Element novo).
  late final Color cor = Color(0xFF000000 | Random().nextInt(0xFFFFFF));

  @override
  Widget build(BuildContext context) {
    return Container(width: 90, height: 90, color: cor);
  }
}
