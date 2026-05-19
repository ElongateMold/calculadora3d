import 'package:flutter/material.dart';
import '../repositories/history_repository.dart';

class HistoryScreen extends StatelessWidget {
  final HistoryRepository historyRepository = FirebaseHistory(); 

  HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: historyRepository.readPrint(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Hubo un error al cargar los datos'));
          }

          List<Map<String, dynamic>> history = snapshot.data ?? [];

          if (history.isEmpty) {
            return const Center(child: Text("No hay impresiones registradas aún."));
          }
          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index];
              return ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("Gramos: ${item['grams']}g | Horas: ${item['hours']}h\nFecha: ${item['date']}"),
                trailing: Text(
                  "\$${item['price'].toStringAsFixed(0)}", 
                  style: const TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              );
            },
          );
        },
      ),
    );
  }
}