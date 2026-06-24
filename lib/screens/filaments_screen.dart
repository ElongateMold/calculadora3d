import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importación clave
import '../providers/filament_provider.dart';
import 'specific_filaments_screen.dart';

class FilamentsScreen extends StatefulWidget {
  const FilamentsScreen({super.key});

  @override
  State<FilamentsScreen> createState() => _FilamentsScreenState();
}

class _FilamentsScreenState extends State<FilamentsScreen> {

  @override
  void initState() {
    super.initState();
    // Le pedimos al Provider que busque los datos apenas la pantalla está lista.
    // Usamos addPostFrameCallback para evitar errores de renderizado.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FilamentProvider>().loadBrandMaterials();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materiales eSUN'),
      ),
      // El Consumer "escucha" al FilamentProvider y se redibuja automáticamente
      body: Consumer<FilamentProvider>(
        builder: (context, provider, child) {
          
          // 1. Estado de carga: Mostramos el círculo girando
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Estado de error: Mostramos el mensaje
          if (provider.error != null) {
            return Center(
              child: Text(
                provider.error!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            );
          }

          // 3. Estado de éxito pero sin datos (lista vacía)
          if (provider.materials.isEmpty) {
            return const Center(child: Text('No se encontraron materiales.'));
          }

          // 4. Estado de éxito con datos: Dibujamos la lista
          return ListView.builder(
            itemCount: provider.materials.length,
            itemBuilder: (context, index) {
              final material = provider.materials[index];
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    material.material, 
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Variantes disponibles: ${material.filamentCount}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Construimos la ruta hacia el index del material
                    final String materialPath = 'materials/${material.slug}/index.json';
                  
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecificFilamentsScreen(
                          title: material.material,
                          apiPath: materialPath,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}