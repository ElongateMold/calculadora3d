class FilamentDetail {
  final String id;
  final String name;
  final String material;
  final double density;
  final PrintSettings settings;

  FilamentDetail({
    required this.id,
    required this.name,
    required this.material,
    required this.density,
    required this.settings,
  });

  factory FilamentDetail.fromJson(Map<String, dynamic> json) {
    return FilamentDetail(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Desconocido',
      material: json['material'] ?? '',
      density: (json['properties']?['density'] ?? 1.24).toDouble(), 
      settings: PrintSettings.fromJson(json['settings'] ?? {}),
    );
  }
}

// Sub-modelo para organizar las temperaturas
class PrintSettings {
  final int extruderTempMin;
  final int extruderTempMax;
  final int bedTempMin;
  final int bedTempMax;

  PrintSettings({
    required this.extruderTempMin,
    required this.extruderTempMax,
    required this.bedTempMin,
    required this.bedTempMax,
  });

  factory PrintSettings.fromJson(Map<String, dynamic> json) {
    return PrintSettings(
      extruderTempMin: json['extruder']?['min'] ?? 200,
      extruderTempMax: json['extruder']?['max'] ?? 220,
      bedTempMin: json['bed']?['min'] ?? 50,
      bedTempMax: json['bed']?['max'] ?? 60,
    );
  }
}