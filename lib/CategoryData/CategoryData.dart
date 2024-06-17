class InitCategory {
  InitCategory({
    this.id,
    this.image,
    this.keyword,
  });


  // Category id
  final String? id;


  final String? image;

  final String? keyword;


  // Make map from InitCategory data
  Map<String, dynamic> makeMap() {
    return {
      'id': id ?? '',
      'image': image ?? '',
      'keyword': keyword ?? '',
    };
  }

  // Load map for InitCategory data
  static InitCategory loadMap(Map<String, dynamic> doc) {
    return InitCategory(
      id: doc['id'],
      image: doc['image'],
      keyword: doc['keyword'],
    );
  }
}
