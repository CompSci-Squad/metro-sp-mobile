import 'package:flutter/material.dart';
import 'src/shared/global/globalVariables.dart';
import 'src/screens/telaCadastrarNovoUsuario.dart';
import 'src/screens/telaPerfil.dart';
import 'src/screens/telaVerificarCadastro.dart';
import 'src/screens/telaVerificarCadastroEncontrado.dart';
import 'src/screens/telaLogin.dart';
import 'src/screens/telaInicial.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(ChangeNotifierProvider(
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
        '/telaCadastrarNovoUsuario': (context) =>
            const TelaCadastrarNovoUsuario(),
        '/telaVerificarCadastroEncontrado': (context) =>
            TelaVerificarCadastroEncontrado(),
        // Adicione mais rotas aqui conforme criar novas telas
      },
    );
  }
}
