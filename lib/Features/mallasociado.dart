// ignore_for_file: deprecated_member_use, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageGridScreen extends StatelessWidget {
  const ImageGridScreen({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 2, 120, 174),
      title: const Text('Malls Asociados'),
    ),
    body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/god.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        children: [
          Container(
            height: 200,
            child: GestureDetector(
              onTap: () => _launchURL('https://mall.costaneracenter.cl/'),
              child: Card(
                child: Image.asset('assets/images/constanera.png'),
              ),
            ),
          ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () => _launchURL('https://www.floridacenter.cl/'),
                child: Card(
                  child: Image.asset('assets/images/FloridaCenter.webp'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () => _launchURL('https://www.mallplaza.com/cl/alameda'),
                child: Card(
                  child: Image.asset('assets/images/alameda.jpeg'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () => _launchURL('https://www.parquearauco.cl/'),
                child: Card(
                  child: Image.asset('assets/images/arauco.webp'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () => _launchURL('https://www.mallplaza.com/cl/egana'),
                child: Card(
                  child: Image.asset('assets/images/egana.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () =>
                    _launchURL('https://www.mallplaza.com/cl/losdominicos'),
                child: Card(
                  child: Image.asset('assets/images/dominicos.jpeg'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () => _launchURL('https://openplaza.cl/es/mall/kennedy'),
                child: Card(
                  child: Image.asset('assets/images/Openkeneddy.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () => _launchURL('hhttps://www.mallplaza.com/cl/sur'),
                child: Card(
                  child: Image.asset('assets/images/plazasur.jpg'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () => _launchURL('https://www.paseoquilin.cl/'),
                child: Card(
                  child: Image.asset('assets/images/quilin.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () =>
                    _launchURL('https://www.mallplaza.com/cl/vespucio'),
                child: Card(
                  child: Image.asset('assets/images/vespucio.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final urlmall = Uri.parse(url);
    if (!await launchUrl(urlmall)) {
      throw Exception('No se pudo abrir la url $urlmall');
    }
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'No se pudo abrir la URL: $url';
    // }
  }
}
