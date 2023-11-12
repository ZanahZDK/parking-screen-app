// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
    );
  }
}

class PerfilPage1 extends StatelessWidget {
  const PerfilPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 120, 174),
        title: const Text('Ver Perfil'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/estacionamiento2.jpg'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 70,
                backgroundImage: const AssetImage('assets/images/id.png'),
                child: Container(
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: const Color.fromARGB(255, 2, 120, 174)
                              .withOpacity(1),
                          width: 5.0)),
                ),
              ),
              const SizedBox(height: 90),
              itemProfile('Nombre', '', CupertinoIcons.person),
              const SizedBox(height: 20),
              itemProfile('Email', '', CupertinoIcons.mail),
              const SizedBox(
                height: 20,
              ),
              itemProfile('Telefono', '', CupertinoIcons.phone),
              const SizedBox(height: 20),
              itemProfile('Patente', '', CupertinoIcons.location),
              const SizedBox(height: 20),
              itemProfile('Rut', '', CupertinoIcons.mail),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: const Color.fromARGB(255, 2, 120, 174).withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.account_circle, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}
