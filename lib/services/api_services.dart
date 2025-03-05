import 'package:ban_x/models/feedback_model.dart';
import 'package:ban_x/utils/constants/banx_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApiServices {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = BanXConstants.FIREBASE_COLLECTION_NAME;
  final String _feedbackCollection = 'feedbacks';

  /// Check if ID already exists
  Future<bool> checkIfIdExists(String id) async {
    try {
      final querySnapshot = await _fireStore
          .collection(_collectionName)
          .where('id', isEqualTo: id)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check ID existence: $e');
    }
  }

  /// Add new ban id
  Future<DocumentReference> addBanId(Map<String, dynamic> data) async {
    try {
      if (await checkIfIdExists(data['id'])) {
        throw Exception("This ID already exists in the database");
      }
      return await _fireStore.collection(_collectionName).add(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Get all ban ids
  Future<Stream<QuerySnapshot>> getBanIds() async {
    try {
      return _fireStore
          .collection(_collectionName)
          .orderBy('createdAt', descending: true)
          .snapshots();
    } catch (e) {
      throw Exception('Failed to get ban IDs!');
    }
  }

  /// Update ban id
  Future<void> updateBanId(String docId, Map<String, dynamic> data) async {
    try {
      await _fireStore.collection(_collectionName).doc(docId).update(data);
    } catch (e) {
      throw Exception('Failed to update ban ID!');
    }
  }

  /// Submit feedback
  Future<DocumentReference> submitFeedback(FeedbackModel feedback) async {
    try {
      return await _fireStore.collection(_feedbackCollection).add(feedback.toJson());
    } catch (e) {
      throw Exception('Failed to submit feedback.');
    }
  }

  /// Get user feedbacks
  Future<Stream<QuerySnapshot>> getUserFeedbacks(String userId) async {
    try {
      return _fireStore
          .collection(_feedbackCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots();
    } catch (e) {
      throw Exception('Failed to get user feedbacks.');
    }
  }

  /// Get all feedbacks
  Future<Stream<QuerySnapshot>> getAllFeedbacks() async {
    try {
      return _fireStore
          .collection(_feedbackCollection)
          .orderBy('createdAt', descending: true)
          .snapshots();
    } catch (e) {
      throw Exception('Failed to update ban ID!');
    }
  }

  /// Delete ban id
  Future<void> deleteBanId(String docId) async {
    try {
      await _fireStore.collection(_collectionName).doc(docId).delete();
    } catch (e) {
      throw Exception('Failed to delete ban ID!');
    }
  }
}