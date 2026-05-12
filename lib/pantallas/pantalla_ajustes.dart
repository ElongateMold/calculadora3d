import 'package:flutter/material.dart';
import '/datos/app_data.dart';

class PantallaAjustes extends StatefulWidget {
  const PantallaAjustes({super.key});

  @override
  State<PantallaAjustes> createState() => _PantallaAjustesState();
}



class _PantallaAjustesState extends State<PantallaAjustes> {
  // Controladores para los campos de texto
  final TextEditingController _precioKgCtrl = TextEditingController();
  final TextEditingController _wattsCtrl = TextEditingController();
  final TextEditingController _kwhCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    _precioKgCtrl.text = AppData.precioPorKg.toString();
    _wattsCtrl.text = AppData.consumoWatts.toString();
    _kwhCtrl.text = AppData.costoKWh.toString();
  }

  void _guardarAjustes() {
    setState(() {
      AppData.precioPorKg = double.tryParse(_precioKgCtrl.text) ?? 15990.0;
      AppData.consumoWatts = double.tryParse(_wattsCtrl.text) ?? 150.0;
      AppData.costoKWh = double.tryParse(_kwhCtrl.text) ?? 126.0;
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
              controller: _precioKgCtrl,
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
