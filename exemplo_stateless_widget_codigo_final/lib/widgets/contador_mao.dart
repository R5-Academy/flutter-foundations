import 'package:flutter/widgets.dart';

class ContadorMao extends Widget {
  const ContadorMao({super.key});

  @override
  Element createElement() => ContadorMaoElement(this);
}

class ContadorMaoElement extends ComponentElement {
  int _contador = 0;

  void atualizeiTela(VoidCallback callback) {
    callback();
    markNeedsBuild(); // Marca o elemento como precisando ser reconstruído
  }

  ContadorMaoElement(super.widget);

  @override
  Widget build() {
    return GestureDetector(
      onTap: () {
        // Handle tap event
        // atualizeiTela(() {
        //   _contador++;
        // });
        _contador++;
        markNeedsBuild();
        print('ContadorMao tapped! $_contador');
      },
      child: Text(_contador.toString()),
    );
  }
}
