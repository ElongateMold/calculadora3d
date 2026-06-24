// 1. EL MODELO INTERMEDIO (Para la lista de "PLA Silk", "PLA Matte", etc.)
class SpecificFilament {
  final String id;
  final String name;
  final String path;
  final int variantCount;

  SpecificFilament({
    required this.id,
    required this.name,
    required this.path,
    required this.variantCount,
  });

  factory SpecificFilament.fromJson(Map<String, dynamic> json) {
    return SpecificFilament(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Desconocido',
      path: json['path'] ?? '',
      variantCount: json['variant_count'] ?? 0,
    );
  }
}

class FilamentDetail {
  final String id;
  final String name;
  final String material; 
  final double density;
  final int extruderTempMin;
  final int extruderTempMax;
  final int bedTempMin;
  final int bedTempMax;

  FilamentDetail({
    required this.id,
    required this.name,
    required this.material,
    required this.density,
    required this.extruderTempMin,
    required this.extruderTempMax,
    required this.bedTempMin,
    required this.bedTempMax,
  });

  factory FilamentDetail.fromJson(Map<String, dynamic> json) {
    return FilamentDetail(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Desconocido',
      material: json['material'] ?? '',
      density: (json['density'] ?? 0.0).toDouble(),
      extruderTempMin: json['min_print_temperature'] ?? 0,
      extruderTempMax: json['max_print_temperature'] ?? 0,
      bedTempMin: json['min_bed_temperature'] ?? 0,
      bedTempMax: json['max_bed_temperature'] ?? 0,
    );
  }
}