// ignore_for_file: use_build_context_synchronously, avoid_print, file_names
// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/RecuperarContrasena.dart';

import 'package:flutter_application_1/main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  bool showpassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.uid);
      Navigator.pop(context);
    }
    super.initState();
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Correo Enviado'),
          content: const Text(
              'Se ha enviado un enlace para restaurar su contraseña a su correo.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColorDark;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/images/Background.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            myColor.withOpacity(1),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: _buildBottom(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bienvenido",
          style: TextStyle(
            color: Color.fromARGB(255, 2, 120, 174),
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
        _buildGreyText("Ingrese su informacion para iniciar sesion"),
        const SizedBox(height: 60),
        _buildGreyText("Correo Electronico"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGreyText("Contraseña"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildRememberForgot(),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
            onTap: isPassword
                ? () {
                    showpassword = !showpassword;
                    setState(() {});
                  }
                : () {},
            child: isPassword
                ? showpassword
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.remove_red_eye)
                : const Icon(Icons.done)),
      ),
      obscureText: isPassword && showpassword,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RecuperarPassword()),
            );
          },
          child: _buildGreyText("Crear Cuenta"),
        ),
        TextButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                final TextEditingController emailResetController =
                    TextEditingController();
                return AlertDialog(
                  title: const Text('Recuperar Contraseña'),
                  content: TextField(
                    controller: emailResetController,
                    decoration: const InputDecoration(
                      hintText: "Ingrese su correo electrónico",
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        String email = emailResetController.text;
                        if (email.isNotEmpty) {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email);
                          Navigator.of(context).pop();
                          _showConfirmationDialog(context);
                        } else {
                          _showErrorDialog(context,
                              "Por favor, ingrese un correo electrónico.");
                        }
                      },
                      child: const Text('Enviar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                  ],
                );
              },
            );
          },
          child: _buildGreyText("Recuperar Contraseña"),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        debugPrint("Email: ${emailController.text}");
        debugPrint("Password: ${passwordController.text}");

        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);
          print(credential.toString());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ParkingApp()),
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          }
        }
      },
      style: ElevatedButton.styleFrom(
        // ignore: prefer_const_constructors
        backgroundColor: Color.fromARGB(255, 2, 120, 174),
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("Ingresar"),
    );
  }
}
