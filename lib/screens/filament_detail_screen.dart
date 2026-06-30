import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/filament_provider.dart';

class FilamentDetailScreen extends StatefulWidget {
  final String title;
  final String apiPath;

  const FilamentDetailScreen({
    super.key,
    required this.title,
    required this.apiPath,
  });

  @override
  State<FilamentDetailScreen> createState() => _FilamentDetailScreenState();
}

class _FilamentDetailScreenState extends State<FilamentDetailScreen> {
  
  @override
  void initState() {
    super.initState();
    // Le pedimos al provider que cargue el detalle específico apenas se abre la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FilamentProvider>().loadSpecificFilament(widget.apiPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de ${widget.title}'),
      ),
      body: Consumer<FilamentProvider>(
        builder: (context, provider, child) {
          
          // 1. Cargando
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Error
          if (provider.error != null) {
            return Center(
              child: Text(
                provider.error!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // 3. Extrayendo el detalle cargado
          final detail = provider.selectedDetail;
          
          if (detail == null) {
            return const Center(child: Text('No hay detalles disponibles.'));
          }

          // 4. Dibujando la interfaz final
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail.name,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                
                // Tarjetas de información técnica
                _buildInfoCard('Densidad', '${detail.density} g/cm³', Icons.science),
                const SizedBox(height: 12),
                _buildInfoCard(
                  'Temp. Extrusor', 
                  '${detail.extruderTempMin}°C - ${detail.extruderTempMax}°C', 
                  Icons.thermostat
                ),
                const SizedBox(height: 12),
                _buildInfoCard(
                  'Temp. Cama', 
                  '${detail.bedTempMin}°C - ${detail.bedTempMax}°C', 
                  Icons.grid_4x4
                ),
                
                // --- NUEVO BOTÓN PARA VOLVER AL INICIO ---
                const Spacer(), // Empuja el botón hacia el final de la pantalla
                ElevatedButton.icon(
                  onPressed: () {
                    // Cierra todas las ventanas hasta llegar a la StartScreen
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: const Icon(Icons.home),
                  label: const Text(
                    'Volver al Inicio',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF58BC7A), // Tu color esmeralda
                    foregroundColor: const Color(0xFF16191A), // Texto oscuro
                    minimumSize: const Size(double.infinity, 50), // Ancho completo
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ], // <-- Este es el cierre de children de tu Column
            ),
          );
        },
      ),
    );
  }

  // Un pequeño widget de ayuda para mantener el código limpio y profesional
  // Un pequeño widget de ayuda para mantener el código limpio y profesional
  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF58BC7A), size: 30), // Tu esmeralda
        title: Text(title, style: const TextStyle(color: Colors.grey)), // El gris funciona en ambos modos
        subtitle: Text(
          value,
          // ¡Aquí eliminamos el Colors.black87!
          style: const TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 18,
          ), 
        ),
      ),
    );
  }
}