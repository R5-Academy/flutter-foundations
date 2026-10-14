import 'package:flutter/widgets.dart';

class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<StatefulWidget> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int _contador = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _contador++;
        });
      },
      child: Text(_contador.toString()),
    );
  }
}
