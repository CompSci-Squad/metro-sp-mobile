import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/global/globalVariables.dart';

class InicialScreen extends StatelessWidget {
  const InicialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: buildAppDrawer(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barra superior com a imagem, como na tela de login
          Container(
            width: double.infinity, // Ocupa toda a largura da tela
            height: 28, // Define a altura para 28
            child: Image.asset(
              'assets/barraMetro.png', // Caminho da imagem
              fit: BoxFit.cover, // A imagem cobre a largura total
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreetingSection(context),
                  _buildThickerDivider(),
                  _buildMapTitle(),
                  _buildThickerDivider(),
                  _buildMapSection(),
                  _buildOperationsText(),
                  _buildThickerDivider(),
                  _buildOperationButtons(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Drawer buildAppDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 20, 137, 1),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem('Cadastrar Novo Usuário', () {
            Navigator.pushNamed(context, '/telaCadastrarNovoUsuario');
          }),
          _buildDrawerItem('Verificar Cadastro Usuário', () {
            Navigator.pushNamed(context, '/telaVerificarCadastro');
          }),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(String title, VoidCallback onTap,
      {Color? textColor}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: textColor ?? Colors.black),
      ),
      onTap: onTap,
    );
  }

  Widget _buildGreetingSection(BuildContext context) {
    final user = Provider.of<GlobalVariables>(context).user;
    final userName = user != null
        ? user["name"] ?? "Nome não disponível"
        : "Nome não disponível";
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 80.0),
          child: ListTile(
            title: Text(
              userName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Verifique suas informações aqui',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/telaPerfil');
            },
          ),
        ),

        // Ícone das três barrinhas que abre o Drawer, posicionado sobre o ListTile
        Positioned(
          left: 0,
          top: 8,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            child: const Icon(
              Icons.person,
              size: 30,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapTitle() {
    return const Center(
      child: Text(
        'Acesse O Mapa Completo Das Vias',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMapSection() {
    return Center(
      child: Container(
        width: 265, // Largura da imagem do mapa
        height: 197, // Altura da imagem do mapa
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/linhasMetro.png'), // Caminho para a imagem do mapa
            fit: BoxFit.contain, // Mantém a proporção da imagem
          ),
        ),
      ),
    );
  }

  Widget _buildOperationsText() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Text(
          'Principais Operações',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildThickerDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 2,
    );
  }

  Widget _buildOperationButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 20.0), // Espaço extra ao redor dos botões
      child: Center(
        child: Column(
          children: [
            buildStyledButton('Cadastrar Novo Usuário', () {
              Navigator.pushNamed(context, '/telaCadastrarNovoUsuario');
            }),
            const SizedBox(height: 20), // Espaço entre os botões
            buildStyledButton('Verificar Cadastro Usuário', () {
              Navigator.pushNamed(context, '/telaVerificarCadastro');
            }),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildStyledButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
        padding: const EdgeInsets.symmetric(
            vertical: 15), // Ajusta a altura do conteúdo do botão
        minimumSize:
            const Size(206, 56), // Define o tamanho do botão como 206x56
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
