import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:category_with_firebase/category_with_firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategoryCRUD {
  // the instance of Firestore
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  // add Category
  static Future<void> addCategory(InitCategory data, Uint8List? image) async {
    final DocumentReference<Map<String, dynamic>> docRef =
        await _instance.collection('category').add(data.makeMap());
    if (image != null) {
      final Reference ref = _storage.ref().child('category/${data.keyword}');
      await ref.putData(data.image! as Uint8List);
      final String url = await ref.getDownloadURL();
      await docRef.update({'image': url});
    }
  }

  // get all Category
  static Future<List<InitCategory>> getCategories() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _instance.collection('category').get();
    return snapshot.docs
        .map((element) => InitCategory.loadMap(element.data()))
        .toList();
  }

  static Future<List<InitCategory>> getKeyword(String keyword) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _instance
        .collection('category')
        .where('keyword', isEqualTo: keyword)
        .get();
    return snapshot.docs
        .map((element) => InitCategory.loadMap(element.data()))
        .toList();
  }

  // update Category
  static Future<void> updateCategory(
      InitCategory data, Uint8List? image, String id) async {
    final DocumentReference<Map<String, dynamic>> docRef =
        _instance.collection('category').doc(id);
    if (data.image != null) {
      final Reference ref = _storage.ref().child('category/${data.keyword}');
      await ref.putData(data.image! as Uint8List);
      final String url = await ref.getDownloadURL();
      await docRef.update({'image': url});
    }
    await docRef.update(data.makeMap());
  }

  // delete Category
  static Future<void> deleteCategory(String id) async {
    await _instance.collection('category').doc(id).delete();
  }
}
