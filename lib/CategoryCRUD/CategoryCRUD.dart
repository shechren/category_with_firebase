import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:category_with_firebase/category_with_firebase.dart';

// the Class for CRUD operation for Category
class CategoryCRUD {
  // the instance of Firestore
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  // add Ordinary
  static Future<void> addOrdinary({required String collection, required String id}) async {
    // 1. get All Ordinary
    // 2. get max Ordinary
    // 3. set max + 1
    // 4. update
    final snapshotAll = await _instance.collection(collection).get();
    int maxOrdinary = 0;
    // get max Ordinary
    for (var e in snapshotAll.docs) {
      if (e['ordinary'] > maxOrdinary) {
        maxOrdinary = e['ordinary'];
      }
    }
    // update
    await _instance.collection(collection).doc(id).update({'ordinary': maxOrdinary + 1});
  }

  // add Category
  static Future<void> addCategory(
      {required String collection, required InitCategory category, String? sub}) async {
    DocumentReference docRef = await _instance.collection(collection).add(category.makeMap());
    // update id and parentId
    await docRef.update({'id': docRef.id, 'parentId': sub ?? ''});
    await addOrdinary(collection: collection, id: docRef.id);
  }

  // get all Category
  static Future<List<InitCategory>> getCategories({required String collection}) async {
    final snapshot = await _instance.collection(collection).get();
    // get all data
    final List<InitCategory> data =
        snapshot.docs.map((e) => InitCategory.loadMap(e.data(), e.id)).toList();
    // sort by ordinary
    data.sort(
      (a, b) => a.ordinary!.compareTo(b.ordinary!),
    );
    return data;
  }

  // get Main Category
  static Future<List<InitCategory>> getMain({required String collection}) async {
    final snapshot = await _instance.collection(collection).where('depth', isEqualTo: 1).get();
    // get all data where depth is 1
    final List<InitCategory> data =
        snapshot.docs.map((e) => InitCategory.loadMap(e.data(), e.id)).toList();
    // sort by ordinary
    data.sort((a, b) => a.ordinary!.compareTo(b.ordinary!));
    return data;
  }

  // get Secondary Category
  static Future<List<InitCategory>> getSecondary(
      {required String collection, required String parentId}) async {
    // get all data where depth is 2 and subId is parentId
    final snapshot = await _instance
        .collection(collection)
        .where('depth', isEqualTo: 2)
        .where('subId', isEqualTo: parentId)
        .get();
    final List<InitCategory> data =
        snapshot.docs.map((e) => InitCategory.loadMap(e.data(), e.id)).toList();
    // sort by ordinary
    data.sort((a, b) => a.ordinary!.compareTo(b.ordinary!));
    return data;
  }

  // get Tertiary Category
  static Future<List<InitCategory>> getTertiary(
      {required String collection, required String parentId}) async {
    // get all data where depth is 3 and subId is parentId
    final snapshot = await _instance
        .collection(collection)
        .where('depth', isEqualTo: 3)
        .where('subId', isEqualTo: parentId)
        .get();
    final List<InitCategory> data =
        snapshot.docs.map((e) => InitCategory.loadMap(e.data(), e.id)).toList();
    // sort by ordinary
    data.sort((a, b) => a.ordinary!.compareTo(b.ordinary!));
    return data;
  }

  // update Category
  static Future<void> updateCategory(
      {required String collection, required String id, required String name}) async {
    await _instance.collection(collection).doc(id).update({'name': name});
  }

  // delete Category
  static Future<void> deleteCategory({required String collection, required String id}) async {
    await _instance.collection(collection).doc(id).delete();
  }
}
