import 'package:cloud_firestore/cloud_firestore.dart';

import '../CategoryData/CategoryData.dart';

class CategoryCRUD {
  static final CollectionReference _collection = FirebaseFirestore.instance.collection('category');

  static Future<void> addOrdinary(String id) async {
    // 1. get All Ordinary
    // 2. get max Ordinary
    // 3. set max + 1
    // 4. update
    final snapshotAll = await _collection.get();
    int maxOrdinary = 0;
    for (var e in snapshotAll.docs) {
      if (e['ordinary'] > maxOrdinary) {
        maxOrdinary = e['ordinary'];
      }
    }
    await _collection.doc(id).update({'ordinary': maxOrdinary + 1});
  }

  static Future<void> addCategory({required InitCategory category, String? sub}) async {
    DocumentReference docRef = await _collection.add(category.makeMap());
    await docRef.update({'id': docRef.id, 'parentId': sub ?? ''});
    await addOrdinary(docRef.id);
  }

  static Future<List<InitCategory>> getCategories() async {
    final snapshot = await _collection.get();
    final List<InitCategory> data = snapshot.docs
        .map((e) => InitCategory.loadMap(e.data() as Map<String, dynamic>, e.id))
        .toList();
    data.sort(
      (a, b) => a.ordinary!.compareTo(b.ordinary!),
    );
    return data;
  }

  static Future<List<InitCategory>> getMain() async {
    final snapshot = await _collection.where('depth', isEqualTo: 1).get();
    final List<InitCategory> data = snapshot.docs
        .map((e) => InitCategory.loadMap(e.data() as Map<String, dynamic>, e.id))
        .toList();
    data.sort((a, b) => a.ordinary!.compareTo(b.ordinary!));
    return data;
  }

  static Future<List<InitCategory>> getSecondary(String parentId) async {
    final snapshot =
        await _collection.where('depth', isEqualTo: 2).where('subId', isEqualTo: parentId).get();
    final List<InitCategory> data = snapshot.docs
        .map((e) => InitCategory.loadMap(e.data() as Map<String, dynamic>, e.id))
        .toList();
    data.sort((a, b) => a.ordinary!.compareTo(b.ordinary!));
    return data;
  }

  static Future<List<InitCategory>> getTertiary(String parentId) async {
    final snapshot =
        await _collection.where('depth', isEqualTo: 3).where('subId', isEqualTo: parentId).get();
    final List<InitCategory> data = snapshot.docs
        .map((e) => InitCategory.loadMap(e.data() as Map<String, dynamic>, e.id))
        .toList();
    data.sort((a, b) => a.ordinary!.compareTo(b.ordinary!));
    return data;
  }

  static Future<void> updateCategory(String id, String name) async {
    await _collection.doc(id).update({'name': name});
  }

  static Future<void> deleteCategory(String id) async {
    await _collection.doc(id).delete();
  }
}
