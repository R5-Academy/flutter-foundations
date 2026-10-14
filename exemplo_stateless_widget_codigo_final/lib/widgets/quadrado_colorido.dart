import 'package:flutter/widgets.dart';

class QuadradoColorido extends Widget {
  final double _lado;
  final Color _cor;

  const QuadradoColorido({super.key, required this._lado, required this._cor});

  @override
  Element createElement() => _QuadradoColoridoElement(this);
}

class _QuadradoColoridoElement extends ComponentElement {
  _QuadradoColoridoElement(super.widget);

  @override
  Widget build() {
    final quadradoColorido = widget as QuadradoColorido;

    return Container(
      width: quadradoColorido._lado,
      height: quadradoColorido._lado,
      color: quadradoColorido._cor,
    );
  }
}
