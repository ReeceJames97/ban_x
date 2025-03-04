import 'package:cloud_firestore/cloud_firestore.dart';

class BanItem {
  final String id;
  final String name;
  final String status;
  final DateTime createdAt;

  BanItem({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
  });

  factory BanItem.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BanItem(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      status: data['status'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}