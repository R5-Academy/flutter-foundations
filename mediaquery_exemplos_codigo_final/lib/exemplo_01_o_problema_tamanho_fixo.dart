// exemplo_01_o_problema_tamanho_fixo.dart
import 'package:flutter/material.dart';

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
            width: 350,
            padding: const .all(24),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: .circular(16),
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
