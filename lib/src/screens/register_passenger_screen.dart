import 'package:flutter/material.dart';
import '../shared/enums/justification_enum.dart';
import '../shared/services/apiService.dart';
import 'package:camera/camera.dart';

import '../shared/utils/justification_map.dart';

class RegisterPassengerScreen extends StatefulWidget {
  const RegisterPassengerScreen({super.key});

  @override
  _RegisterPassengerScreen createState() => _RegisterPassengerScreen();
}

class _RegisterPassengerScreen extends State<RegisterPassengerScreen> {
  JustificationType? selectedReason;
  XFile? capturedImage;
  late String justificationText = "";
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _justificationDetailsController =
      TextEditingController();

  void handleImageCaptured(XFile image) {
    capturedImage = image;
  }

  Future<void> _submitUser() async {
    final String cpf = _cpfController.text.trim();
    final String name = _nameController.text.trim();
    final String surname = _surnameController.text.trim();
    final String justificationDetails =
        _justificationDetailsController.text.trim();
    final String? reasonValue = selectedReason?.toString().split('.').last;

    if (!_isValidInput(cpf, name, surname, justificationDetails, reasonValue)) {
      setState(() {
        _showErrorDialog();
      });
      return;
    }

    if (capturedImage?.name == null) {
      setState(() {
        _showErrorDialog(message: "Por favor, capture uma imagem.");
      });
      return;
    }

    try {
      await apiService.sendMultipartFormData(
        url: '/passenger',
        fields: {
          'cpf': cpf,
          'name': '$name $surname',
          'justificationType': reasonValue ?? "",
          'justificationDetails': justificationDetails,
        },
        file: capturedImage!,
        fileFieldName: "file",
      );

      _showSuccessDialog(message: "Passageiro criado com sucesso");
      Navigator.pushReplacementNamed(context, '/telaInicial');
    } catch (e) {
      print(e);
      setState(() {
        _showErrorDialog(
            message: "Erro ao realizar o cadastro. Tente novamente.");
      });
    }
  }

// Helper function for input validation
  bool _isValidInput(String cpf, String name, String surname,
      String justificationDetails, String? reasonValue) {
    return cpf.isNotEmpty &&
        name.isNotEmpty &&
        surname.isNotEmpty &&
        justificationDetails.isNotEmpty &&
        reasonValue?.isNotEmpty == true;
  }

  // Navegar para a próxima tela

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: buildAppDrawer(context),
      body: SingleChildScrollView(
        // Adiciona scroll na tela
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
                  const SizedBox(height: 5),
                  _buildNameField(),
                  const SizedBox(height: 5),
                  _buildSurnameField(),
                  const SizedBox(height: 5),
                  _buildReasonField(),
                  const SizedBox(height: 5),
                  _buildRightField(),
                  const SizedBox(height: 5),
                  _buildPhotoSection(),
                  const SizedBox(height: 40),
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

  void _showErrorDialog({String message = 'Dados Incompletos'}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 20, 137, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSuccessDialog(
      {String message = 'Operação concluída com sucesso!'}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 20, 137, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
        const Padding(
          padding: EdgeInsets.only(left: 80.0, top: 8.0, bottom: 8.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
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
      children: [
        const Text(
          'Digite o C.P.F do usuário',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _cpfController,
          obscureText: false,
          decoration: InputDecoration(
            hintText: '***.***.***-**',
            filled: true,
            fillColor: const Color.fromRGBO(0, 20, 137, 1),
            hintStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Digite O nome do usuário',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _nameController,
          obscureText: false,
          decoration: InputDecoration(
            hintText: '_______',
            filled: true,
            fillColor: const Color.fromRGBO(0, 20, 137, 1),
            hintStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
        )
      ],
    );
  }

  Widget _buildSurnameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Digite o sobrenome do usuário',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _surnameController,
          obscureText: false,
          decoration: InputDecoration(
            hintText: '_______',
            filled: true,
            fillColor: const Color.fromRGBO(0, 20, 137, 1),
            hintStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildReasonField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione O motivo da gratuidade',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<JustificationType>(
          value: selectedReason,
          items: JustificationType.values.map((JustificationType reason) {
            return DropdownMenuItem<JustificationType>(
              value: reason,
              child: Text(
                justificationTypeTranslations[reason] ?? 'Unknown',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: (JustificationType? newValue) {
            setState(() {
              selectedReason = newValue;
              switch (selectedReason) {
                case JustificationType.AGE:
                  justificationText = 'Digite a sua data de nascimento (ano-mês-dia)';
                  break;
                case JustificationType.UNEMPLOYED:
                  justificationText = 'Digite seu numero de cadastro';
                  break;
                case JustificationType.POLICEOFFICER:
                  justificationText = 'Digite seu código da funcional';
                  break;
                case JustificationType.PCD:
                  justificationText = 'Digite o motivo';
                  break;
                default:
                  justificationText = 'Please select a justification type.';
              }
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(0, 20, 137, 1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          style: const TextStyle(color: Colors.white),
          dropdownColor: const Color.fromRGBO(0, 20, 137, 1),
        ),
      ],
    );
  }

  Widget _buildRightField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          justificationText,
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _justificationDetailsController,
          obscureText: false,
          decoration: InputDecoration(
            hintText: '',
            filled: true,
            fillColor: const Color.fromRGBO(0, 20, 137, 1),
            hintStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras(); // Lista de câmeras disponíveis
    cameraController = CameraController(
      cameras[0], // Escolhe a câmera principal
      ResolutionPreset.medium, // Define a qualidade da câmera
    );

    await cameraController.initialize(); // Inicializa o controlador
    if (mounted) {
      setState(() {}); // Atualiza o estado para renderizar o CameraPreview
    }
  }

  Future<void> _capturePhoto() async {
    if (!cameraController.value.isInitialized) {
      return; // Retorna se a câmera não está inicializada
    }

    try {
      final XFile image =
          await cameraController.takePicture(); // Captura a foto
      print('Foto capturada em: ${image.path}');
      // Salve o arquivo ou carregue-o para o backend
    } catch (e) {
      print('Erro ao capturar a foto: $e');
    }
  }

  @override
  void dispose() {
    cameraController.dispose(); // Libera os recursos da câmera
    _cpfController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _justificationDetailsController.dispose();
    super.dispose();
  }

  Widget _buildPhotoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fotografe o Usuário',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                // Navigate to CameraFullScreenPage and capture the image
                final XFile? image = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraFullScreenPage(
                      cameraController: cameraController,
                      onImageCaptured: handleImageCaptured,
                    ),
                  ),
                );
                // If a photo was taken, store it in the class variable
                if (image != null) {
                  setState(() {
                    capturedImage = image; // Store the captured image
                  });
                }
              },
              icon: const Icon(Icons.camera_alt, size: 40, color: Colors.black),
            ),
            const SizedBox(width: 100),
            IconButton(
              onPressed: () {
                if (capturedImage != null) {
                  // Display the captured image or use it
                  print("Captured Image Path: ${capturedImage!.path}");
                } else {
                  // Handle case when no photo has been taken yet
                  print("No image captured yet");
                }
              },
              icon: const Icon(Icons.person, size: 40, color: Colors.black),
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
          child: const Text(
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

class CameraFullScreenPage extends StatelessWidget {
  final CameraController cameraController;
  final Function(XFile) onImageCaptured;

  CameraFullScreenPage(
      {required this.cameraController, required this.onImageCaptured});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            cameraController.value.isInitialized
                ? CameraPreview(cameraController) // Full screen camera preview
                : const Center(child: CircularProgressIndicator()),
            Positioned(
              top: 40,
              left: 16,
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context); // Navigate back
                },
              ),
            ),
            Positioned(
              bottom: 40,
              right: 16,
              child: FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: () async {
                  try {
                    final XFile image = await cameraController.takePicture();
                    onImageCaptured(image);
                    Navigator.pop(context);
                  } catch (e) {
                    print('Erro ao capturar a foto: $e');
                  }
                },
                child: const Icon(Icons.camera, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
