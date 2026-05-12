import 'package:flutter/material.dart';
import '/datos/app_data.dart';

class PantallaHistorial extends StatelessWidget {
  const PantallaHistorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial')),
      body: AppData.historial.isEmpty
          ? const Center(child: Text("No hay impresiones registradas aún."))
          : ListView.builder(
              itemCount: AppData.historial.length,
              itemBuilder: (context, index) {
                final item = AppData.historial[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(item['nombre'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        "Gramos: ${item['gramos']}g | Horas: ${item['horas']}h\nFecha: ${item['fecha']}"),
                    trailing: Text(
                      "\$${item['precio'].toStringAsFixed(0)}",
                      style: const TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
        );
    }
}