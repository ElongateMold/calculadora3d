import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/datos/app_data.dart';

class PantallaCalcular extends StatefulWidget {
  const PantallaCalcular({super.key});

  @override
  State<PantallaCalcular> createState() => _PantallaCalcularState();
}

class _PantallaCalcularState extends State<PantallaCalcular> {
  final TextEditingController _nombreCtrl = TextEditingController();
  final TextEditingController _gramosCtrl = TextEditingController();
  final TextEditingController _horasCtrl = TextEditingController();
  
  String _resultado = "";

  void _realizarCalculo() {
    double gramos = double.tryParse(_gramosCtrl.text) ?? 0.0;
    double horas = double.tryParse(_horasCtrl.text) ?? 0.0;

    // 1. Costo del plástico
    double precioPorGramo = AppData.precioPorKg / 1000;
    double costoFilamento = gramos * precioPorGramo;

    // 2. Costo por hora (Luz + Desgaste de máquina) * Margen de error
    double costoEnergiaHora = (AppData.consumoWatts / 1000) * AppData.costoKWh;
    double costoHoraReal = (costoEnergiaHora + AppData.desgasteMaquinaHora) * AppData.margenError;
    double costoTotalHoras = horas * costoHoraReal;

    // 3. Costo Base (Lo que te cuesta a ti producirlo)
    double costoBase = costoFilamento + costoTotalHoras;

    // 4. Precio de Venta Final (Costo Base * Multiplicador de Ganancia)
    double precioFinalVenta = costoBase * AppData.multiplicadorGanancia;

    setState(() {
      _resultado = "Precio Sugerido: \$${precioFinalVenta.toStringAsFixed(0)}";
    });

    String nombre = _nombreCtrl.text.isNotEmpty ? _nombreCtrl.text : 'Impresión #${AppData.historial.length + 1}';
    
    AppData.historial.insert(0, {
      'nombre': nombre,
      'precio': precioFinalVenta,
      'gramos': gramos,
      'horas': horas,
      'fecha': DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()),
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calcular Precio')),
      body: SingleChildScrollView( // Para evitar que el teclado tape el contenido
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreCtrl,
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
                    controller: _gramosCtrl,
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
                    controller: _horasCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Horas (h)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _realizarCalculo,
              child: const Text('Calcular Total'),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: Text(
                _resultado.isEmpty ? "Ingresa los datos para calcular" : _resultado,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}