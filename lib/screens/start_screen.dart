import 'package:calculartor3d/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'config_screen.dart';
import 'calculate_screen.dart';
import 'history_screen.dart';
import 'auth_screen.dart';

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
        title: const Text('3D Calculator'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Calculadora de precio de impresiones 3D',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  label: const Text('Ajustes'),
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
              label: const Text('Ver Historial'),
            ),
          ],
        ),
      ),
    );
  }
}