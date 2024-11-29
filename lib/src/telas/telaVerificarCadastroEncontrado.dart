import 'package:flutter/material.dart';
import '../services/apiService.dart';
import cpf
class TelaVerificarCadastroEncontrado extends StatefulWidget {
  @override
  _TelaVerificarCadastroEncontradoState createState() => _TelaVerificarCadastroEncontradoState();
}

class _TelaVerificarCadastroEncontradoState extends State<TelaVerificarCadastroEncontrado> {




final postResponse = await apiService.get('/passenger/', {
      'name': nome,

      'C.P.F': cpf,
      'motivo':
      'direito':

    });










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

              // Conteúdo principal
              _buildOperationButtons(),
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
            Navigator.pushReplacementNamed(context, '/telaCadastrarNovoUsuario');
          }),
          _buildDrawerItem('Verificar Cadastro Usuário', () {
            Navigator.pushReplacementNamed(context, '/telaVerificarCadastro');
          }),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(String title, VoidCallback onTap, {Color? textColor}) {
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
          padding: const EdgeInsets.only(left: 80.0, top: 8.0, bottom: 8.0), // Ajusta o espaçamento ao redor do ListTile
          child: ListTile(
            contentPadding: EdgeInsets.zero, // Remove o padding interno do ListTile
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
                Scaffold.of(context).openDrawer(); // Abre o Drawer ao clicar nas três barrinhas
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

  Widget _buildOperationButtons() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0), // Espaço extra ao redor dos botões
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Digite o C.P.F. do Usuário',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: false,
            decoration: InputDecoration(
              hintText: '***.***.***-**',
              filled: true,
              fillColor: Color.fromRGBO(0, 20, 137, 1),
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 200, // Ajuste a largura conforme necessário
              child: ElevatedButton(
                onPressed: () {
                  // Navegar para a próxima tela
                  // Navigator.pushNamed(context, '');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
                  padding: EdgeInsets.symmetric(vertical: 20), // Aumenta a altura do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'Verificar',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
          SizedBox(height: 10), // Espaço entre o botão e a mensagem
          Center(
            child: Column(
              children: [
                Text(
                  'Usuário encontrado no banco de dados',
                  style: TextStyle(
                    color: Colors.green, // Cor verde
                    fontSize: 14, // Tamanho de fonte 14
                  ),
                ),
                SizedBox(height: 10), // Espaço entre a mensagem e o ícone
                Icon(
                  Icons.account_circle,
                  size: 50,
                  color: Color.fromRGBO(0, 20, 137, 1), // Cor azul do perfil
                ),
              ],
            ),
          ),
        ],
      ),
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
          /*child: const Text(
            text, // O texto que será exibido, vindo do backend
            style: TextStyle(color: Colors.white, fontSize: 14),
          )*/
        ),
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
          /*child: const Text(
            text, // O texto que será exibido, vindo do backend
            style: TextStyle(color: Colors.white, fontSize: 14),
          )*/
        ),
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
          /*child: const Text(
            text, // O texto que será exibido, vindo do backend
            style: TextStyle(color: Colors.white, fontSize: 14),
          )*/
        ),
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
          /*child: const Text(
            text, // O texto que será exibido, vindo do backend
            style: TextStyle(color: Colors.white, fontSize: 14),
          )*/
        ),
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
          /*child: const Text(
            text, // O texto que será exibido, vindo do backend
            style: TextStyle(color: Colors.white, fontSize: 14),
          )*/
        ),
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
