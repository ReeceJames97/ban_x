import 'package:ban_x/utils/constants/banx_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApiServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = BanXConstants.FIREBASE_COLLECTION_NAME;

  /// Add new ban id
  Future<DocumentReference> addBanId(Map<String, dynamic> data) async {
    try {
      return await _firestore.collection(_collectionName).add(data);
    } catch (e) {
      throw Exception('Failed to add ban ID: $e');
    }
  }

  /// Get all ban ids
  Future<Stream<QuerySnapshot>> getBanIds() async {
    try {
      return _firestore
          .collection(_collectionName)
          .orderBy('createdAt', descending: true)
          .snapshots();
    } catch (e) {
      throw Exception('Failed to get ban IDs: $e');
    }
  }

  /// Update ban id
  Future<void> updateBanId(String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(_collectionName).doc(docId).update(data);
    } catch (e) {
      throw Exception('Failed to update ban ID: $e');
    }
  }

  /// Delete ban id
  Future<void> deleteBanId(String docId) async {
    try {
      await _firestore.collection(_collectionName).doc(docId).delete();
    } catch (e) {
      throw Exception('Failed to delete ban ID: $e');
    }
  }
}