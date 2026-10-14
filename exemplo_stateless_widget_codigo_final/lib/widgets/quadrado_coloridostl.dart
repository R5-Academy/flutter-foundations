import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuadradoColoridostl extends StatelessWidget {
  // ignore: prefer_final_fields
  double _lado;
  final Color _cor;

  QuadradoColoridostl({super.key, required this._lado, required this._cor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: _lado, height: _lado, color: _cor),
        ElevatedButton(
          onPressed: () {
            _lado *= 2;
          },
          child: const Text("Press Me"),
        ),
      ],
    );
  }
}
