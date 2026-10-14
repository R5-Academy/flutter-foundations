import 'package:flutter/material.dart';
import 'package:primeiro_layout/pages/widgets/corpo_boas_vindas.dart';

class BoasVindas extends StatelessWidget {
  const BoasVindas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: .expand,
        children: [
          Image.asset('assets/images/background.png', fit: .cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: .center,
                end: .bottomCenter,
                colors: [Colors.black45, Colors.black87],
              ),
            ),
          ),

          CorpoBoasVindas(),
        ],
      ),
    );
  }
}
