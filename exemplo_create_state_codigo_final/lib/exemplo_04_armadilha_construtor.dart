import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Demo()));
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  var _titulo = 'Versao A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('createState: Construtor vs Widget')),
      body: Column(
        children: [
          CardCerto(titulo: _titulo),
          CardErrado(titulo: _titulo),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _titulo = _titulo == 'Versao A' ? 'Versao B' : 'Versao A';
          });
        },
        label: Text('Trocar Titulo'),
      ),
    );
  }
}

class CardCerto extends StatefulWidget {
  final String _titulo;
  const CardCerto({super.key, required this._titulo});

  @override
  State<CardCerto> createState() => _CardCertoState();
}

class _CardCertoState extends State<CardCerto> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.check, color: Colors.blue),
      title: Text(widget._titulo),
    );
  }
}

class CardErrado extends StatefulWidget {
  final String _titulo;
  const CardErrado({super.key, required this._titulo});

  @override
  State<CardErrado> createState() => _CardErradoState(_titulo);
}

class _CardErradoState extends State<CardErrado> {
  // ignore: prefer_final_fields
  String _titulo;
  _CardErradoState(this._titulo);

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.hashCode.toString());
    return ListTile(
      leading: Icon(Icons.close, color: Colors.red),
      title: Text(_titulo),
    );
  }
}
