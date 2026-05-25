import 'package:flutter/material.dart';
import '../data/printer_data.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}



class _ConfigScreenState extends State<ConfigScreen> {
  // Controladores para los campos de texto
  final TextEditingController _priceKgCtrl = TextEditingController();
  final TextEditingController _wattsCtrl = TextEditingController();
  final TextEditingController _kwhCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    _priceKgCtrl.text = AppData.pricePerKg.toString();
    _wattsCtrl.text = AppData.wattsConsume.toString();
    _kwhCtrl.text = AppData.kWhCost.toString();
  }

  void _guardarAjustes() {
    setState(() {
      AppData.pricePerKg = double.tryParse(_priceKgCtrl.text) ?? 15990.0;
      AppData.wattsConsume = double.tryParse(_wattsCtrl.text) ?? 150.0;
      AppData.kWhCost = double.tryParse(_kwhCtrl.text) ?? 126.0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ajustes guardados correctamente')),
    );
    Navigator.pop(context); // Vuelve a la pantalla anterior
  }

  @override
  Widget build(BuildContext context) {
    // El Scaffold añade la flecha para poder volver atrás
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _priceKgCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Precio de filamento por Kg (\$)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _wattsCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Consumo impresora (Watts)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _kwhCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Costo de energía (\$ por kWh)',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _guardarAjustes,
                child: const Text('Guardar Ajustes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
