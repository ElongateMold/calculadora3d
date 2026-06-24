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
  List<FilamentMaterial> get materials => _materials;
  FilamentDetail? get selectedDetail => _selectedDetail;

  // --- NUEVAS VARIABLES PARA LA PANTALLA INTERMEDIA ---
  List<SpecificFilament> _specificFilaments = [];
  List<SpecificFilament> get specificFilaments => _specificFilaments;

  // --- NUEVO MÉTODO PARA CARGAR LA LISTA INTERMEDIA (Ej: Todas las variantes de PLA) ---
  Future<void> loadSpecificFilamentsList(String materialPath) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Usamos tu misma función del repositorio, porque el path que viene en el JSON ya está listo
      // Ej: materialPath = "materials/PLA/index.json"
      final data = await _repository.fetchSpecificFilament(materialPath);
      
      if (data['filaments'] != null) {
        final List<dynamic> filamentsList = data['filaments'];
        _specificFilaments = filamentsList.map((json) => SpecificFilament.fromJson(json)).toList();
      }
    } catch (e) {
      _error = 'Error al cargar variantes: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

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

  Future<void> loadSpecificFilament(String materialPath) async {
     _isLoading = true;
    _error = null;
    notifyListeners(); // Avisamos a la UI que muestre el ícono de carga

    try {
      // 1. Usamos el repositorio de forma limpia
      final data = await _repository.fetchSpecificFilament(materialPath);
      
      // 2. Transformamos el mapa JSON a nuestro modelo Dart
      _selectedDetail = FilamentDetail.fromJson(data);
      
    } catch (e) {
      _error = 'Error al cargar el detalle: $e';
    } finally {
      _isLoading = false;
      notifyListeners(); // Avisamos a la UI que ya tenemos los datos
    }
  }
}