import 'package:flutter/material.dart';
import '../services/apiService.dart';

class TelaVerificarCadastro extends StatefulWidget {
  @override
  _TelaVerificarCadastroState createState() => _TelaVerificarCadastroState();
}

class _TelaVerificarCadastroState extends State<TelaVerificarCadastro> {
  final TextEditingController _cpfController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _submitUser() async {
    final String cpf = _cpfController.text;

    if (cpf.isEmpty) {
      setState(() {
        _errorMessage = "O campo CPF não pode estar vazio.";
      });
      return;
    }

    print('CPF: $cpf');
    final postResponse = await apiService.post('/login', {
      'CPF': cpf,
    });
    print(postResponse);

    if (!postResponse.containsKey("accessToken")){
      setState(() {
        //_showErrorDialog();
      });
      //return;
    } else{
      Navigator.pushReplacementNamed(context,'/telaVerificarCadastroEncontrado');
    }
    // Navegar para a próxima tela
    //Navigator.pushNamed(context, '/telaInicial');
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: buildAppDrawer(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 28,
            child: Image.asset(
              'assets/barraMetro.png',
              fit: BoxFit.cover,
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
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  if (_isLoading)
                    Center(child: CircularProgressIndicator()),
                  _buildOperationButtons(context),
                  Spacer(),
                  _buildBackButton(context),
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
          padding: const EdgeInsets.only(left: 80.0, top: 8.0, bottom: 8.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Verificar Cadastro Usuário',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 8,
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                size: 43,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
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

  Widget _buildOperationButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Digite o C.P.F. Do Usuário',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _cpfController,
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
                width: 200,
                child: ElevatedButton(
                  onPressed: _submitUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
                    padding: EdgeInsets.symmetric(vertical: 20),
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
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: IconButton(
        icon: Icon(Icons.arrow_back, size: 30),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
