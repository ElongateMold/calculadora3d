import 'package:calculartor3d/repositories/auth_repository.dart';
import 'package:calculartor3d/screens/filaments_screen.dart';
import 'package:flutter/material.dart';
import 'parameters_screen.dart';
import 'calculate_screen.dart';
import 'history_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
  
  
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    final AuthRepository authRepository = Login();
    authRepository.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('THREED'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Calculadora de precio de impresiones 3D',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CalculateScreen()),
                    );
                  },
                  label: const Text('Calcular'),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ConfigScreen()),
                    );
                  },
                  label: const Text('Parámetros'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryScreen()),
                );
              },
              label: const Text('Historial'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilamentsScreen()),
                );
              },
              label: const Text('Filamentos'),
            ),
          ],
        ),
      ),
    );
  }
}