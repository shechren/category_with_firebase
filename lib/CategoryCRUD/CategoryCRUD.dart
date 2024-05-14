import 'package:cloud_firestore/cloud_firestore.dart';

import '../CategoryData/CategoryData.dart';

class CategoryCRUD {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  static Future<void> addOrdinary({required String collection, required String id}) async {
    // 1. get All Ordinary
    // 2. get max Ordinary
    // 3. set max + 1
    // 4. update
    final snapshotAll = await _instance.collection(collection).get();
    int maxOrdinary = 0;
    for (var e in snapshotAll.docs) {
      if (e['ordinary'] > maxOrdinary) {
        maxOrdinary = e['ordinary'];
      }
    }
    await _instance.collection(collection).doc(id).update({'ordinary': maxOrdinary + 1});
  }

  static Future<void> addCategory(
      {required String collection, required InitCategory category, String? sub}) async {
    DocumentReference docRef = await _instance.collection(collection).add(category.makeMap());
    await docRef.update({'id': docRef.id, 'parentId': sub ?? ''});
    await addOrdinary(collection: collection, id: docRef.id);
  }

  static Future<List<InitCategory>> getCategories({required String collection}) async {
    final snapshot = await _instance.collection(collection).get();
    final List<InitCategory> data =
        snapshot.docs.map((e) => InitCategory.loadMap(e.data(), e.id)).toList();
    data.sort(
      (a, b) => a.ordinary!.compareTo(b.ordinary!),
    );
    return data;
  }

  static Future<List<InitCategory>> getMain({required String collection}) async {
    final snapshot = await _instance.collection(collection).where('depth', isEqualTo: 1).get();
    final List<InitCategory> data =
        snapshot.docs.map((e) => InitCategory.loadMap(e.data(), e.id)).toList();
    data.sort((a, b) => a.ordinary!.compareTo(b.ordinary!));
    return data;
  }

  static Future<List<InitCategory>> getSecondary(
      {required String collection, required String parentId}) async {
    final snapshot = await _instance
        .collection(collection)
        .where('depth', isEqualTo: 2)
        .where('subId', isEqualTo: parentId)
        .get();
    final List<InitCategory> data =
        snapshot.docs.map((e) => InitCategory.loadMap(e.data(), e.id)).toList();
    data.sort((a, b) => a.ordinary!.compareTo(b.ordinary!));
    return data;
  }

  static Future<List<InitCategory>> getTertiary(
      {required String collection, required String parentId}) async {
    final snapshot = await _instance
        .collection(collection)
        .where('depth', isEqualTo: 3)
        .where('subId', isEqualTo: parentId)
        .get();
    final List<InitCategory> data =
        snapshot.docs.map((e) => InitCategory.loadMap(e.data(), e.id)).toList();
    data.sort((a, b) => a.ordinary!.compareTo(b.ordinary!));
    return data;
  }

  static Future<void> updateCategory(
      {required String collection, required String id, required String name}) async {
    await _instance.collection(collection).doc(id).update({'name': name});
  }

  static Future<void> deleteCategory({required String collection, required String id}) async {
    await _instance.collection(collection).doc(id).delete();
  }
}
