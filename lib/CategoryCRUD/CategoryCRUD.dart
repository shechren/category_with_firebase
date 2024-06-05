import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:category_with_firebase/category_with_firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';

// the Class for CRUD operation for Category
class CategoryCRUD {
  // the instance of Firestore
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  // add Primary
  static Future<int> addPrimary(
      {required String collection, required String id}) async {
    final snapshotAll = await _instance.collection(collection).get();
    int maxPrimary = 0;
    for (var e in snapshotAll.docs) {
      if (e['primary'] > maxPrimary) {
        maxPrimary = e['primary'];
      }
    }
    await _instance
        .collection(collection)
        .doc(id)
        .update({'primary': maxPrimary + 1});

    return maxPrimary + 1;
  }

  // add Ordinary
  static Future<void> addOrdinary(
      {required String collection,
      required String id,
      required int depth}) async {
    final snapshotAll = await _instance
        .collection(collection)
        .where('depth', isEqualTo: depth)
        .get();
    int maxOrdinary = 0;
    for (var e in snapshotAll.docs) {
      if (e['ordinary'] > maxOrdinary) {
        maxOrdinary = e['ordinary'];
      }
    }
    await _instance
        .collection(collection)
        .doc(id)
        .update({'ordinary': maxOrdinary + 1});
  }

  // add Category
  static Future<void> addCategory(
      {required String collection,
      required InitCategory category,
      int? parentPrimary,
      Uint8List? image}) async {
    DocumentReference docRef =
        await _instance.collection(collection).add(category.makeMap());

    await docRef.update({'id': docRef.id, 'parentPrimary': parentPrimary ?? 0});
    int primary = await addPrimary(collection: collection, id: docRef.id);
    await addOrdinary(
        collection: collection, id: docRef.id, depth: category.depth);

    if (image != null) {
      Reference ref =
      _storage.ref().child('$collection/${primary.toString()}');
      await ref.putData(image, SettableMetadata(contentType: 'image/png'));
      final imageUrl = await _storage
          .ref('$collection/${primary.toString()}')
          .getDownloadURL();
      await docRef.update({'image': imageUrl});
    }
  }

  // get all Category
  static Future<List<InitCategory>> getCategories(
      {required String collection}) async {
    final snapshot = await _instance.collection(collection).get();
    final List<InitCategory> data =
        snapshot.docs.map((e) => InitCategory.loadMap(e.data(), e.id)).toList();
    data.sort(
      (a, b) => a.primary!.compareTo(b.primary!),
    );
    return data;
  }

  // get Main Category
  static Future<List<InitCategory>> getMain(
      {required String collection}) async {
    final snapshot = await _instance
        .collection(collection)
        .where('depth', isEqualTo: 1)
        .get();
    final List<InitCategory> data =
        snapshot.docs.map((e) => InitCategory.loadMap(e.data(), e.id)).toList();
    data.sort((a, b) => a.primary!.compareTo(b.primary!));
    return data;
  }

  // get Secondary Category
  static Future<List<InitCategory>> getSecondary(
      {required String collection, required int parentPrimary}) async {
    final snapshot = await _instance
        .collection(collection)
        .where('depth', isEqualTo: 2)
        .where('parentPrimary', isEqualTo: parentPrimary)
        .get();
    final List<InitCategory> data =
        snapshot.docs.map((e) => InitCategory.loadMap(e.data(), e.id)).toList();
    data.sort((a, b) => a.primary!.compareTo(b.primary!));
    return data;
  }

  // get Tertiary Category
  static Future<List<InitCategory>> getTertiary(
      {required String collection, required int parentPrimary}) async {
    final snapshot = await _instance
        .collection(collection)
        .where('depth', isEqualTo: 3)
        .where('parentPrimary', isEqualTo: parentPrimary)
        .get();
    final List<InitCategory> data =
        snapshot.docs.map((e) => InitCategory.loadMap(e.data(), e.id)).toList();
    data.sort((a, b) => a.primary!.compareTo(b.primary!));
    return data;
  }

  // update Category
  static Future<void> updateCategory(
      {required String collection,
      required int primary,
      required String name}) async {
    await _instance.collection(collection).doc(primary.toString()).update({'name': name});
  }

  // delete Category
  static Future<void> deleteCategory(
      {required String collection, required int primary}) async {
    await _instance.collection(collection).doc(primary.toString()).delete();
  }
}
