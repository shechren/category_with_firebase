// 기본 카테고리 클래스
class InitCategory {
  InitCategory(
      {required this.name,
      required this.depth,
      this.id,
      this.parentId,
      this.ordinary});

  final String name;
  final int depth;
  final String? id;
  final String? parentId;
  final int? ordinary;

  Map<String, dynamic> makeMap() {
    return {
      'name': name,
      'depth': depth,
      'id': id ?? '',
      'parentId': parentId ?? '',
      'ordinary': ordinary ?? 0,
    };
  }

  static InitCategory loadMap (Map<String, dynamic> doc, String id) {
    return InitCategory(
      name: doc['name'],
      depth: doc['depth'],
      id: doc['id'],
      parentId: doc['parentId'],
      ordinary: doc['ordinary'],
    );
  }
}
