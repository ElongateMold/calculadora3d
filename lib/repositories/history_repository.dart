
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Separación de clases 
// Solo define qué hace
abstract class HistoryRepository {
  Future<void> savePrint(Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> readPrint();
  Future<int> counter();
  Future<void> deletePrint(String id);
}

class FirebaseHistory implements HistoryRepository {
  @override
  Future<void> savePrint(Map<String, dynamic> data) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    
    final db = FirebaseFirestore.instance;
    await db
        .collection('users')
        .doc(uid)
        .collection('history')
        .add(data);
  }

  @override
Future<void> deletePrint(String id) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final db = FirebaseFirestore.instance;
  await db
      .collection('users')
      .doc(uid)
      .collection('history')
      .doc(id)
      .delete();
}
  
  @override
Future<List<Map<String, dynamic>>> readPrint() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  
  if (uid == null) return []; 

  final db = FirebaseFirestore.instance;
  
  final snapshot = await db
      .collection('users')
      .doc(uid)              
      .collection('history') 
      .orderBy('date', descending: true)
      .get();
  
  List<Map<String, dynamic>> history = [];
  for (var doc in snapshot.docs) {
    final data = doc.data();
    data['id'] = doc.id;
    history.add(data);
  }
  return history;
}

  @override
  Future<int> counter() async {
    final db = FirebaseFirestore.instance;
    final snapshot = await db.collection('history').count().get();
    int counter = snapshot.count ?? 0;
    return counter;
  }


}

