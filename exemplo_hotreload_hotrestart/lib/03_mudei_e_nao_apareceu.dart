// 03_mudei_e_nao_apareceu.dart
// Demonstra: o misterio "mudei o codigo e nada apareceu". A causa quase sempre e
//   o ciclo de vida: o que roda so no initState (ou na inicializacao de um campo)
//   NAO e reexecutado no Hot Reload, porque o State e preservado.
// Novo em relacao ao 02: agora o valor vem do initState, nao de um clique.
// Passo a passo:
//   1. Rode: a saudacao mostra "Ola, turma da manha".
//   2. Troque "manha" por "noite" na linha do initState e salve (Hot Reload).
//      -> a tela NAO muda. initState nao roda de novo no reload.
//   3. De um Hot Restart (R) -> agora aparece "Ola, turma da noite".
//   4. (Bonus) Mude o valor inicial `final int _versao = 1` para 2 e repita: Reload
//      nao mostra; Hot Restart mostra. Inicializador de campo tambem so roda na
//      criacao do State.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaSaudacao()));

class TelaSaudacao extends StatefulWidget {
  const TelaSaudacao({super.key});

  @override
  State<TelaSaudacao> createState() => _TelaSaudacaoState();
}

class _TelaSaudacaoState extends State<TelaSaudacao> {
  final int _versao =
      1; // ! valor inicial: so vale para um State recem-criado (Restart)
  late String _saudacao;

  @override
  void initState() {
    super.initState();
    // ! Este texto e montado UMA vez, na criacao do State. Mudar a string aqui
    //   e dar Hot Reload nao surte efeito: initState nao roda de novo. Precisa de
    //   Hot Restart.
    _saudacao = 'Ola, turma da manha';
  }

  @override
  Widget build(BuildContext context) {
    // O build roda no reload, mas ele so LE o _saudacao ja montado. Como o valor
    // veio do initState (que nao rodou), a tela continua igual.
    return Scaffold(
      appBar: AppBar(title: Text('Versao $_versao')),
      body: Center(
        child: Text(
          _saudacao,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
