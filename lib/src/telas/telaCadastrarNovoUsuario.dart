import 'package:flutter/material.dart';
import '../services/apiService.dart';

class telaCadastrarNovoUsuario extends StatefulWidget {
  @override
  _telaCadastrarNovoUsuario createState() => _telaCadastrarNovoUsuario();
}

class _telaCadastrarNovoUsuario extends State<telaCadastrarNovoUsuario>{
  final List<String> reasons = ["Idade", "P.C.D.", "Desempregado", "Policial"];
  String? selectedReason;
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
 // final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  
  Future<void> _submitUser() async {
    final String cpf = _cpfController.text;
    final String nome = _nomeController.text;
    final String sobrenome = _sobrenomeController.text;
    //final String reason = _reasonController.text;
    final String descricao = _descricaoController.text;


    if (cpf.isEmpty || nome.isEmpty || sobrenome.isEmpty || descricao.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both username and password.';
      });
      return;
    }
    print('CPF: $cpf');
    print('Nome: $nome');
    print('Sobrenome: $sobrenome');
    print('Descrição: $descricao' );

    final postResponse = await apiService.post('/login', {
      'CPF': cpf,
      'Nome': nome,
      'Sobrenome': sobrenome,
      'Descrição': descricao,
    });
    print(postResponse);

    if (!postResponse.containsKey("accessToken")){
      setState(() {
        //_showErrorDialog();
      });
      //return;
    } else{
      //Navigator.pushReplacementNamed(context,'/telaInicial');
    }
    // Navegar para a próxima tela
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: buildAppDrawer(context),
      body: SingleChildScrollView( // Adiciona scroll na tela
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra superior com a imagem, como na tela de login
            Container(
              width: double.infinity,
              height: 28,
              child: Image.asset(
                'assets/barraMetro.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreetingSection(context),
                  _buildThickerDivider(),
                  _buildCPFField(),
                  SizedBox(height: 5),
                  _buildNameField(),
                  SizedBox(height: 5),
                  _buildSurnameField(),
                  SizedBox(height: 5),
                  _buildReasonField(),
                  SizedBox(height: 5),
                  _buildRightField(),
                  SizedBox(height: 5),
                  _buildPhotoSection(),
                  SizedBox(height: 40),
                  _buildSubmitButton(),
                ],
              ),
            ),
            _buildBackButton(context),
          ],
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
          padding: const EdgeInsets.only(left: 80.0, top: 8.0, bottom: 8.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Cadastro de Novos Usuários',
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

 Widget _buildCPFField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children : [
        Text (
          'Digite o C.F.P. Do Usuário',
          style: TextStyle(fontSize: 12),
        ),
        //SizedBox(height: 10),
        SizedBox(
          height: 30,
          child: TextField(
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
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Digite O Nome do Usuário',
          style: TextStyle(fontSize: 12),
        ),
        //SizedBox(height: 10),
        SizedBox(
          height: 30,
          child: TextField(
          controller: _nomeController,
          obscureText: false,
          decoration: InputDecoration(
            hintText: '_______',
            filled: true,
            fillColor: Color.fromRGBO(0, 20, 137, 1),
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
        )
        
        ),
      ],
    );
  }

  Widget _buildSurnameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Digite o Sobrenome Do Usuário',
          style: TextStyle(fontSize: 12),
        ),
        //SizedBox(height: 10),
        SizedBox(
          height: 30,
          child: TextField(
          controller: _sobrenomeController,
          obscureText: false,
          decoration: InputDecoration(
            hintText: '_______',
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
        )
        
      ],
    );
  }

  Widget _buildReasonField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecione O Motivo da Gratuidade',
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedReason,
          items: reasons.map((String reason) {
            return DropdownMenuItem<String>(
              value: reason,
              child: Text(reason, style: TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            selectedReason = newValue;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromRGBO(0, 20, 137, 1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          style: TextStyle(color: Colors.white), // Estilo do texto selecionado
          dropdownColor: Color.fromRGBO(0, 20, 137, 1), // Cor do menu suspenso
        ),
      ],
    );
  }


  Widget _buildRightField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Digite direitoGratuidade',
          style: TextStyle(fontSize: 12),
        ),
        //SizedBox(height: 10),
        SizedBox(
          height: 30,
          child: TextField(
            controller: _descricaoController,
          obscureText: false,
          decoration: InputDecoration(
            hintText: '',
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
        )
        
      ],
    );
  }

  

Widget _buildPhotoSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Fotografe o Usuário',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              // Ação para tirar foto
            },
            icon: Icon(Icons.camera_alt, size: 40, color: Colors.black),
          ),
          SizedBox(width: 100), // Aumenta o espaçamento lateral entre os ícones
          IconButton(
            onPressed: () {
              // Ação para visualizar foto
            },
            icon: Icon(Icons.person, size: 40, color: Colors.black),
          ),
        ],
      ),
    ],
  );
}


  Widget _buildSubmitButton() {
    return Center(
      child: SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: () {
            _submitUser();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            'Cadastrar',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
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
