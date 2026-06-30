import 'package:calculartor3d/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/calculator_service.dart';
import '../repositories/history_repository.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _gramsCtrl = TextEditingController();
  final TextEditingController _hoursCtrl = TextEditingController();
  final HistoryRepository historyRepository = FirebaseHistory();
  String _result = "";

  void _doCalculation() async {
    double grams = double.tryParse(_gramsCtrl.text) ?? 0.0;
    double hours = double.tryParse(_hoursCtrl.text) ?? 0.0;
    double finalSalePrice = CalculatorService.calculateTotal(grams, hours);
    int counterTitle = await historyRepository.counter() + 1;
    String name = _nameCtrl.text.isNotEmpty ? _nameCtrl.text : 'Impresión #$counterTitle';

    setState(() {
      _result = "Precio Sugerido: \$${finalSalePrice.toStringAsFixed(0)}";
    });
    
    Map<String, dynamic> data = {
      'name': name,
      'price': finalSalePrice,
      'grams': grams,
      'hours': hours,
      'date': DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()),
    };
    
    
    historyRepository.savePrint(data);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calcular Precio')),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre de la pieza (Opcional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _gramsCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Gramos (g)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: _hoursCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Horas (h)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30), // Un poco más de espacio antes del botón
            
            // EL NUEVO BOTÓN PROTAGONISTA
            ElevatedButton(
              onPressed: _doCalculation,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark, // Tu esmeralda brillante
                foregroundColor: const Color(0xFF16191A), // Texto oscuro para máximo contraste
                minimumSize: const Size(double.infinity, 55), // Ocupa todo el ancho
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4, // Sombra para que resalte en modo oscuro
              ),
              child: const Text(
                'Calcular Total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // EL CONTENEDOR CONDICIONAL
            // Solo se dibujará en pantalla si _result tiene algún texto
            if (_result.isNotEmpty)
              Container(
                width: double.infinity, // Para que el recuadro se vea uniforme con el botón
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary, // Fondo verde oscuro
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.primaryDark, width: 1.5),
                ),
                child: Text(
                  _result,
                  textAlign: TextAlign.center, // Centramos el texto del precio
                  style: const TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Aseguramos que el texto sea blanco
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}