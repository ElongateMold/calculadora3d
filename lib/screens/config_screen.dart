import 'package:calculartor3d/main.dart';
import 'package:flutter/material.dart';
// Tu clase de colores globales

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // 1. Creamos la variable que guardará el modo seleccionado
  final _modoActual = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configuración de Tema',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            DropdownButton<ThemeMode>(
              value: _modoActual,
              isExpanded: true,  
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('Seguir al Sistema'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Modo Claro'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Modo Oscuro'),
                ),
              ],
              onChanged: (ThemeMode? nuevoModo) {
                if (nuevoModo != null) {
                  themeNotifier.value = nuevoModo;
                  
                  setState(() {});                  
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}