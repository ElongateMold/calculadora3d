import 'dart:convert';
import 'package:http/http.dart' as http;

class FilamentRepository {
  // Asigna la ruta de la API
  static const String baseUrl = 'https://api.openfilamentdatabase.org/api/v1';

  Future<Map<String, dynamic>> fetchBrandFilaments(String brandSlug) async {
    final url = Uri.parse('$baseUrl/brands/$brandSlug/index.json');
    
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error al cargar datos: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión a la API');
    }
  }
}