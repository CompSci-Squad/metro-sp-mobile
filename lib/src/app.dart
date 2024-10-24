import 'package:flutter/material.dart';
import 'package:tela_login/src/telas/telaLogin.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: Scaffold(
        body: telaLogin(),
      )
    );    
  }
}
