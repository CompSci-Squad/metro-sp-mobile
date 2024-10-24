import 'package:flutter/material.dart';
import '../blocs/bloc.dart';

class telaLogin extends StatelessWidget {
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
          submitButton(),
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
            fillColor: Colors.grey[200], // Cor de fundo dentro do campo de texto
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ), // Personaliza a borda ao focar
          ),
        );
      },
    );
  }

  Widget passwordField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Digite sua senha',
        labelText: 'Senha',
        border: OutlineInputBorder(), // Borda retangular
        filled: true, // Habilita o preenchimento interno
        fillColor: Colors.blue[200], // Cor de fundo dentro do campo de texto
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
    );
  }

  Widget submitButton() {
    return Container(
      margin: EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Adicionar a lógica de acesso aqui
              },
              child: Text('Acessar'),
            ),
          ),
        ],
      ),
    );
  }
}
