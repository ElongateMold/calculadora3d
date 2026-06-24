import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/filament_provider.dart';
import 'filament_detail_screen.dart'; // Asegúrate de importar la pantalla final

class SpecificFilamentsScreen extends StatefulWidget {
  final String title;
  final String apiPath;

  const SpecificFilamentsScreen({
    super.key,
    required this.title,
    required this.apiPath,
  });

  @override
  State<SpecificFilamentsScreen> createState() => _SpecificFilamentsScreenState();
}

class _SpecificFilamentsScreenState extends State<SpecificFilamentsScreen> {
  @override
  void initState() {
    super.initState();
    // Cargamos la lista intermedia (ej: todas las variantes de PLA)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FilamentProvider>().loadSpecificFilamentsList(widget.apiPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Variantes de ${widget.title}'),
      ),
      body: Consumer<FilamentProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!, style: const TextStyle(color: Colors.red)));
          }

          if (provider.specificFilaments.isEmpty) {
            return const Center(child: Text('No se encontraron variantes.'));
          }

          return ListView.builder(
            itemCount: provider.specificFilaments.length,
            itemBuilder: (context, index) {
              final filament = provider.specificFilaments[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    filament.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Variantes de color: ${filament.variantCount}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {

                    final String fullPath = widget.apiPath.replaceAll('index.json', filament.path);
                    // ¡Navegación final a la pantalla de detalles!
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilamentDetailScreen(
                          title: filament.name,
                          // Le pasamos el path específico (ej: filaments/pla_silk/index.json)
                          apiPath: fullPath, 
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