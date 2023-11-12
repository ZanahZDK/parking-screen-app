// ignore: file_names
// ignore_for_file: unused_import, file_names, duplicate_ignore, use_build_context_synchronously, avoid_print, unused_local_variable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recovery Password',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const RecuperarPassword(),
    );
  }
}

class RecuperarPassword extends StatefulWidget {
  const RecuperarPassword({Key? key}) : super(key: key);

  @override
  State<RecuperarPassword> createState() => _LoginPageState();
}

class _LoginPageState extends State<RecuperarPassword> {
  late Color myColor;
  late Size mediaSize;
  bool showpassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController patenteController = TextEditingController();
  TextEditingController rutController = TextEditingController();
  late DatabaseReference ref;
  late FirebaseDatabase rtdb;

  bool rememberUser = false;

  @override
  void initState() {
    final firebaseApp = Firebase.app();
    rtdb = FirebaseDatabase.instanceFor(
        app: firebaseApp,
        databaseURL: 'https://sparking-399700-default-rtdb.firebaseio.com');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColorDark;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/images/estacionamiento3.jpeg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            myColor.withOpacity(0.0),
            BlendMode.color,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: 80,
              child: _buildTop(),
            ),
            Positioned(
              bottom: 0,
              child: _buildBottom(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Parking Finder",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              letterSpacing: 2,
            ),
          ),
        ],
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
        _buildGreyText("Ingrese Su Informacion Para Recuperar Su Cuenta"),
        const SizedBox(height: 50),
        _buildGreyText("Correo Electronico"),
        _buildInputField(emailController),
        const SizedBox(height: 15),
        _buildGreyText("Contraseña"),
        _buildInputField(
          passwordController,
          isPassword: true,
        ),
        const SizedBox(height: 15),
        _buildGreyText("Nombre Completo"),
        _buildInputField(nameController),
        const SizedBox(height: 15),
        _buildGreyText("Patente"),
        _buildInputField(patenteController),
        const SizedBox(height: 15),
        _buildGreyText("Rut"),
        _buildInputField(rutController),
        const SizedBox(height: 15),
        _buildGreyText("Telefono"),
        _buildInputField(phoneController),
        const SizedBox(height: 15),
        _buildLoginButton(),
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

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        debugPrint("Email: ${emailController.text}");
        debugPrint("Password: ${passwordController.text}");

        try {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          User usuario = credential.user!;
          await usuario.updateDisplayName(nameController.text);

          await usuario.reload();

          final user = {
            'name': nameController.text,
            'email': emailController.text,
            'patente': patenteController.text,
            'rut': rutController.text,
            'phone': phoneController.text,
          };

          ref = rtdb.ref('user/${usuario.uid}');

          await ref.set(user);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ParkingApp()),
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 2, 120, 174),
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("Registrar"),
    );
  }
}
