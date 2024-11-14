import 'package:flutter/material.dart';
import '../blocs/bloc.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centraliza os campos verticalmente
        crossAxisAlignment: CrossAxisAlignment.start, // Alinha os campos à esquerda
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: emailField(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: passwordField(),
          ),
          SizedBox(height: 20.0), // Espaço adicional entre os campos e o botão
          submitButton(context),
        ],
      ),
    );
  }

  Widget emailField() {
    return StreamBuilder(
      stream: bloc.email, // Vinculado ao stream do bloc
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextField(
          onChanged: (newValue) {
            bloc.changeEmail(newValue);
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Digite seu e-mail @metro',
            labelText: 'E-mail',
            errorText: snapshot.hasError ? snapshot.error.toString() : null,
            border: OutlineInputBorder(), // Borda retangular
            filled: true, // Habilita o preenchimento interno
            fillColor: Color.fromRGBO(0, 20, 137, 1), // Cor de fundo dentro do campo de texto
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(001489), width: 2.0),
            ), // Personaliza a borda ao focar
          ),
        );
      },
    );
  }

  Widget passwordField() {
    return TextField(
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        hintText: 'Digite sua senha',
        labelText: 'Senha',
        border: OutlineInputBorder(), // Borda retangular
        filled: true, // Habilita o preenchimento interno
        fillColor: Color.fromRGBO(0, 20, 137, 1), // Cor de fundo dentro do campo de texto
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(001489), width: 1.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
        ),
        onPressed: () {
            _obscurePassword = _obscurePassword;
        },
        )
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(top: 12.0),
      
      child: SizedBox(
        width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/telaInicial');// Adicionar a lógica de acesso aqui
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900], // Corrigido para backgroundColor
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              child: const Text('Acessar',style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
      );
  }
}
