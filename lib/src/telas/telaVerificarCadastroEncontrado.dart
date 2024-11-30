import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../globalVariables.dart';

class TelaVerificarCadastroEncontrado extends StatefulWidget {
  @override
  _TelaVerificarCadastroEncontradoState createState() =>
      _TelaVerificarCadastroEncontradoState();
}

class _TelaVerificarCadastroEncontradoState
    extends State<TelaVerificarCadastroEncontrado> {
  late Map<String, dynamic> passenger;
  @override
  void initState() {
    super.initState();
    passenger = Provider.of<GlobalVariables>(context, listen: false).passengerResponse!;
    _onScreenRendered();
  }

  void _onScreenRendered() {
    print(passenger);
    // You can perform any task here (e.g., fetching data, logging, etc.)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: buildAppDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Barra superior com a imagem
                Container(
                  width: double.infinity,
                  height: 28,
                  child: Image.asset(
                    'assets/barraMetro.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),

                // Cabeçalho
                _buildGreetingSection(context),
                _buildThickerDivider(),
                SizedBox(height: 10),
                _buildProfileImage(passenger["image"]),
                // Conteúdo principal
                SizedBox(height: 10),
                _buildNameField(),
                SizedBox(height: 5),
                _buildSurnameField(),
                SizedBox(height: 5),
                _buildCPFField(),
                SizedBox(height: 5),
                _buildReasonField(),
                SizedBox(height: 5),
                _buildRightField(),
                SizedBox(height: 20),

                // Botão Voltar
                Align(
                  alignment: Alignment.bottomLeft,
                  child: _buildBackButton(context),
                ),
              ],
            ),
          ),
        ),
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
            Navigator.pushReplacementNamed(
                context, '/telaCadastrarNovoUsuario');
          }),
          _buildDrawerItem('Verificar Cadastro Usuário', () {
            Navigator.pushReplacementNamed(context, '/telaVerificarCadastro');
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
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 80.0,
              top: 8.0,
              bottom: 8.0), // Ajusta o espaçamento ao redor do ListTile
          child: ListTile(
            contentPadding:
                EdgeInsets.zero, // Remove o padding interno do ListTile
            title: const Text(
              'Verificar Cadastro Usuário',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          left: 0, // Ícone alinhado bem ao canto esquerdo
          top: 8, // Alinhamento vertical com o ListTile
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                size: 43, // Tamanho do ícone
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context)
                    .openDrawer(); // Abre o Drawer ao clicar nas três barrinhas
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThickerDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 2,
    );
  }

  Widget _buildProfileImage(String? imageUrl) {
    return Center(
      child: CircleAvatar(
        radius: 40, // Tamanho do círculo
        backgroundColor: Colors.grey[300], // Cor de fundo padrão
        backgroundImage: imageUrl != null && imageUrl.isNotEmpty
            ? NetworkImage(imageUrl) // Carrega a foto da URL
            : null, // Nenhuma imagem se a URL for inválida
        child: imageUrl == null || imageUrl.isEmpty
            ? Icon(
                Icons.person,
                size: 50, // Ícone de "perfil"
                color: Colors.black54,
              )
            : null, // Não mostra ícone se houver imagem
      ),
    );
  }

  Widget _buildNameField(/*String text*/) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nome',
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 30,
          child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 20, 137, 1),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                passenger["name"].split(" ")[0],
                style: TextStyle(color: Colors.white, fontSize: 14),
              )),
        ),
      ],
    );
  }

  Widget _buildSurnameField(/*String text*/) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sobrenome',
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 30,
          child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 20, 137, 1),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                passenger["name"].split(
                    " ")[1], // O texto que será exibido, vindo do backend
                style: TextStyle(color: Colors.white, fontSize: 14),
              )),
        ),
      ],
    );
  }

  Widget _buildCPFField(/*String text*/) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'C.P.F.',
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 30,
          child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 20, 137, 1),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                passenger["cpf"],
                style: TextStyle(color: Colors.white, fontSize: 14),
              )),
        ),
      ],
    );
  }

  Widget _buildReasonField(/*String text*/) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Motivo da Gratuidade',
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 30,
          child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 20, 137, 1),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                passenger['justificationType'],
                style: TextStyle(color: Colors.white, fontSize: 14),
              )),
        ),
      ],
    );
  }

  Widget _buildRightField(/*String text*/) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'direitoGratuidade',
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 30,
          child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 20, 137, 1),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                passenger['justificationDetails'],
                style: TextStyle(color: Colors.white, fontSize: 14),
              )),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: IconButton(
        icon: Icon(Icons.arrow_back, size: 30),
        onPressed: () {
          Navigator.pop(context); // Retorna à tela anterior
        },
      ),
    );
  }
}
