import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela Inicial Metrô',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: telaInicio(),
    );
  }
}

class telaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('COMPANHIA DO METROPOLITANO DE SÃO PAULO'),
            Spacer(),
            Icon(Icons.train),
            Text(' METRÔ'),
          ],
        ),
        backgroundColor: Colors.blue[900],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[900],
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Cadastrar Novo Usuário'),
              onTap: () {
                // Implementar ação para cadastro
              },
            ),
            ListTile(
              title: Text('Verificar Cadastro Usuário'),
              onTap: () {
                // Implementar ação para verificar cadastro
              },
            ),
            ListTile(
              title: Text('Verificar Status Do Totem'),
              onTap: () {
                // Implementar ação para verificar status
              },
            ),
            ListTile(
              title: Text(
                'Reportar Falha De Totem',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                // Implementar ação para reportar falha
              },
            ),
            ListTile(
              title: Text('Desbloquear Totem'),
              onTap: () {
                // Implementar ação para desbloquear totem
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Olá, Nome',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Verifique suas informações aqui',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    'Acesse O Mapa Completo Das Vias',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300, // Ajustar conforme necessário
                    height: 300, // Ajustar conforme necessário
                    color: Colors.grey[300],
                    child: Center(
                      child: Text('Espaço para imagem do mapa'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
