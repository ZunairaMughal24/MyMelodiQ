import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:melodiq/screens/home.dart';

void main() {
  runApp(const MelodiQApp());
}

class MelodiQApp extends StatelessWidget {
  const MelodiQApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'melodiQ',
      home: MelodiQHomePage(),
    );
  }
}

class MelodiQHomePage extends StatelessWidget {
  const MelodiQHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Future.delayed to navigate after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(221, 29, 28, 28),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.music_note,
                size: 100.0,
                color: Color.fromARGB(255, 145, 23, 53),
              ),
              SizedBox(height: 20.0),
              Text(
                'melodiQ',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
