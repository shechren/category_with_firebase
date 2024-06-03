class InitCategory {
  InitCategory(
      {required this.name,
        required this.depth,
        this.id,
        this.parentPrimary,
        this.primary,
        this.ordinary});

  // Category name
  final String name;
  // Category depth
  final int depth;
  // Category id
  final String? id;
  // Category parent primary
  final int? parentPrimary;
  // Category primary
  final int? primary;
  // Category ordinary
  final int? ordinary;

  // Make map from InitCategory data
  Map<String, dynamic> makeMap() {
    return {
      'name': name,
      'depth': depth,
      'id': id ?? '',
      'parentPrimary': parentPrimary ?? 0,
      'primary': primary ?? 0,
      'ordinary': ordinary ?? 0,
    };
  }

  // Load map for InitCategory data
  static InitCategory loadMap(Map<String, dynamic> doc, String id) {
    return InitCategory(
      name: doc['name'],
      depth: doc['depth'],
      id: doc['id'],
      parentPrimary: doc['parentPrimary'],
      primary: doc['primary'],
      ordinary: doc['ordinary'],
    );
  }
}