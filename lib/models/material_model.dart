class FilamentMaterial {
  final String id;
  final String material;
  final String slug;
  final int filamentCount;

  FilamentMaterial({
    required this.id,
    required this.material,
    required this.slug,
    required this.filamentCount,
  });

  factory FilamentMaterial.fromJson(Map<String, dynamic> json) {
    return FilamentMaterial(
      id: json['id'],
      material: json['material'],
      slug: json['slug'],
      filamentCount: json['filament_count'] ?? 0,
    );
  }
}