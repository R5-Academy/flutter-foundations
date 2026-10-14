import 'package:flutter/material.dart';

class CorpoBoasVindas extends StatelessWidget {
  const CorpoBoasVindas({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const .all(26),
        child: Column(
          mainAxisAlignment: .end,
          children: [
            Text(
              'Bem-vindo!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: .bold,
              ),
            ),
            Text(
              'Ao seu primeiro app Flutter',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: .bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Esta é uma tela simples feita \n especialmente para iniciantes',
              textAlign: .center,
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            SizedBox(height: 24),
            Container(
              padding: .all(16),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: .circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: .circle,
                    ),
                    child: Icon(
                      Icons.rocket_launch,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: .start,
                    spacing: 4,
                    children: [
                      Text(
                        'Pronto para aprender?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: .bold,
                        ),
                      ),
                      Text(
                        'Flutter é incrível! vaos construir \ncoisas incriveis juntos',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: .bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: .symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: .circular(16)),
                ),
                icon: Icon(Icons.arrow_forward, size: 24),
                iconAlignment: .end,
                label: Text(
                  'Vamos Começar',
                  style: TextStyle(fontSize: 18, fontWeight: .bold),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
