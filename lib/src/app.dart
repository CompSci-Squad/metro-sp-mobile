import 'package:flutter/material.dart';
import 'package:tela_login/src/telas/telaLogin.dart';
import 'package:tela_login/src/telas/telaCadastrarNovoUsuario.dart';
import 'package:tela_login/src/telas/telaPerfil.dart';
import 'package:tela_login/src/telas/telaVerificarCadastro.dart';
import 'package:tela_login/src/telas/telaVerificarStatusTotem.dart';
import 'package:tela_login/src/telas/telaReportarFalhaTotem.dart';
import 'package:tela_login/src/telas/telaDesbloquearTotem.dart';
import 'package:tela_login/src/telas/telaInicial.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Define a tela de login como inicial
      routes: {
        '/': (context) => LoginPage(),
        '/telaInicial': (context) => telaInicial(),
        '/telaVerificarCadastro': (context) => telaVerificarCadastro(),
        '/telaVerificarStatusTotem': (context) => telaVerificarStatusTotem(),
        '/telaReportarFalhaTotem' : (context) => telaReportarFalhaTotem(),
        '/telaDesbloquearTotem': (context) => telaDesbloquearTotem(),
        '/telaPerfil': (context) => telaPerfil(),
        '/telaCadastrarNovoUsuario': (context) => telaCadastrarNovoUsuario(),
        // Adicione mais rotas aqui conforme criar novas telas
      },
    );
  }
}

