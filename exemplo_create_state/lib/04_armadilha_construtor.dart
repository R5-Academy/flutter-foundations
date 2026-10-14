// 04_armadilha_construtor.dart
// Demonstra: a armadilha classica de passar dados pelo CONSTRUTOR do State
//   (errado) versus ler via `widget.propriedade` (certo) — lado a lado.
// Novo em relacao ao 03: aqui a gente ve o BUG acontecer. Quando o pai reconstroi
//   com um valor novo, a versao errada CONGELA no valor antigo; a certa acompanha.

import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MaterialApp(home: Demo()));
}

// Tela pai: um botao troca o "tema" passado para os dois cards abaixo. E a nova
// config que revela quem congela e quem acompanha.
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
      appBar: AppBar(title: const Text('createState: construtor vs widget')),
      body: Column(
        children: [
          // A cada troca, o pai reconstroi e passa um titulo NOVO para os filhos.
          CardErrado(titulo: _titulo),
          CardCerto(titulo: _titulo),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(
          () => _titulo = _titulo == 'Versao A' ? 'Versao B' : 'Versao A',
        ),
        label: const Text('Trocar titulo'),
      ),
    );
  }
}

// ! ERRADO: passar o dado pelo construtor do State e copiar para um campo.
class CardErrado extends StatefulWidget {
  const CardErrado({super.key, required this.titulo});

  final String titulo;

  // ! Anti-padrao: NAO passe dados pelo construtor do State. Repare que o proprio
  //   lint do Flutter (no_logic_in_create_state) reclama disto — ignoramos aqui so
  //   pra MOSTRAR o erro; no seu codigo, siga o que o linter manda.
  @override
  // ignore: no_logic_in_create_state
  State<CardErrado> createState() => _CardErradoState(titulo);
}

class _CardErradoState extends State<CardErrado> {
  _CardErradoState(this._titulo);

  // ! Este campo e preenchido UMA vez, la no createState, e nunca mais muda.
  //   Como createState nao roda de novo, quando o pai passar um titulo novo
  //   este valor fica CONGELADO no antigo.
  final String _titulo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.close, color: Colors.red),
      title: Text('Errado (construtor): $_titulo'),
    );
  }
}

// * CERTO: guardar o dado no widget e ler via `widget.titulo`.
class CardCerto extends StatefulWidget {
  const CardCerto({super.key, required this.titulo});

  final String titulo;

  @override
  State<CardCerto> createState() => _CardCertoState();
}

class _CardCertoState extends State<CardCerto> {
  @override
  Widget build(BuildContext context) {
    // * `widget` sempre aponta para a configuracao ATUAL. O framework atualiza
    //   isso quando o pai reconstroi -> o titulo novo aparece na hora.
    return ListTile(
      leading: const Icon(Icons.check, color: Colors.green),
      title: Text('Certo (widget): ${widget.titulo}'),
    );
  }
}

// Ao clicar em "Trocar titulo": o card CERTO muda; o card ERRADO fica preso na
// "Versao A". Mesma causa que faz o estado persistir (createState roda 1x) e o
// que causa o bug aqui — por isso os dados de fora moram no widget, nao no State.
