import 'package:flutter/material.dart';
import 'src/globalVariables.dart';
import 'src/telas/telaCadastrarNovoUsuario.dart';
import 'src/telas/telaPerfil.dart';
import 'src/telas/telaVerificarCadastro.dart';
import 'src/telas/telaVerificarCadastroEncontrado.dart';
import 'src/telas/telaLogin.dart';
import 'src/telas/telaInicial.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalVariables(),
      child: MyApp(),
    ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Define a tela de login como inicial
      routes: {
        '/': (context) => LoginPage(),
        '/telaInicial': (context) => const TelaInicial(),
        '/telaVerificarCadastro': (context) => TelaVerificarCadastro(),
        '/telaPerfil': (context) => TelaPerfil(),
        //'/telaCadastrarNovoUsuario': (context) => const TelaCadastrarNovoUsuario(),
        '/telaVerificarCadastroEncontrado': (context) =>
            TelaVerificarCadastroEncontrado(),
        // Adicione mais rotas aqui conforme criar novas telas
      },
    );
  }
}
