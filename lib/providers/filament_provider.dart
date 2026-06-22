import 'package:flutter/material.dart';
import '../repositories/filament_repository.dart';
import '../models/material_model.dart'; // Agregamos el modelo de la lista
import '../models/filament_model.dart'; // Tu modelo de datos de detalles

class FilamentProvider extends ChangeNotifier {
  final FilamentRepository _repository = FilamentRepository();
  
  bool _isLoading = false;
  String? _error;
  
  // 1. La lista básica que se mostrará en las tarjetas
  List<FilamentMaterial> _materials = []; 
  
  // 2. El detalle que se llenará solo cuando el usuario seleccione un material
  FilamentDetail? _selectedDetail; 

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<FilamentMaterial> get materials => _materials; // ¡Ojo! Cambié dynamic por tu modelo
  FilamentDetail? get selectedDetail => _selectedDetail;

  // --- PASO 1: CARGAR LA LISTA DE MATERIALES ---
  Future<void> loadBrandMaterials() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _repository.fetchBrandFilaments('esun_3d');
      
      // Aquí está la magia: extraemos solo el arreglo "materials" del JSON
      if (data['materials'] != null) {
        final List<dynamic> materialsList = data['materials'];
        
        // Transformamos cada mapa de la lista en nuestro objeto Dart
        _materials = materialsList.map((json) => FilamentMaterial.fromJson(json)).toList();
      }
      
    } catch (e) {
      _error = 'Error al procesar los materiales: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- PASO 2: CARGAR LOS DETALLES DE UN MATERIAL ESPECÍFICO ---
  Future<void> loadSpecificFilament(String materialPath) async {
     // Aquí irá la lógica cuando el usuario toque una tarjeta.
     // Harás un http.get(url_base + materialPath)
     // y guardarás el resultado en _selectedDetail.
  }
}