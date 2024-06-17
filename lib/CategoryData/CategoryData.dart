class InitCategory {
  InitCategory({
    required this.depth,
    this.id,
    this.image,
    this.keyword,
  });

  // Category depth
  final int depth;

  // Category id
  final String? id;


  final String? image;

  final String? keyword;


  // Make map from InitCategory data
  Map<String, dynamic> makeMap() {
    return {
      'depth': depth,
      'id': id ?? '',
      'image': image ?? '',
      'keyword': keyword ?? '',
    };
  }

  // Load map for InitCategory data
  static InitCategory loadMap(Map<String, dynamic> doc) {
    return InitCategory(
      depth: doc['depth'],
      id: doc['id'],
      image: doc['image'],
      keyword: doc['keyword'],
    );
  }
}
