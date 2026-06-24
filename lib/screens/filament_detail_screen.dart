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
              ],
            ),
          );
        },
      ),
    );
  }

  // Un pequeño widget de ayuda para mantener el código limpio y profesional
  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF58BC7A), size: 30), // Tu esmeralda
        title: Text(title, style: const TextStyle(color: Colors.grey)),
        subtitle: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
        ),
      ),
    );
  }
}