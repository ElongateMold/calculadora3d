class Brand {
  final String id;
  final String name;
  final String slug;
  final int materialCount;

  Brand({
    required this.id,
    required this.name,
    required this.slug,
    required this.materialCount,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      materialCount: json['material_count'] ?? 0, 
    );
  }
}