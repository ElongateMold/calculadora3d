import 'package:flutter/material.dart';
import '/pantallas/pantalla_inicio.dart';

void main() {
  runApp(const MiCalculadora3DApp());
}

class MiCalculadora3DApp extends StatelessWidget {
  const MiCalculadora3DApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PantallaInicio(),
    );
  }
}