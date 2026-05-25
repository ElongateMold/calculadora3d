
import 'package:cloud_firestore/cloud_firestore.dart';

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
    final db = FirebaseFirestore.instance;
    await db.collection('history').add(data);
  }

  @override
  Future<void> deletePrint(String id) async {
    final db = FirebaseFirestore.instance;
    await db.collection('history').doc(id).delete();
  }
  
  @override
  Future<List<Map<String, dynamic>>> readPrint() async {
    final db = FirebaseFirestore.instance;
    final snapshot = await db.collection('history').orderBy('date', descending: true).get();
    List<Map<String, dynamic>> listHistory = [];

    for (var doc in snapshot.docs) {
      final data = doc.data();
      data['id'] = doc.id;
      listHistory.add(data);
    }
    return listHistory;
  }

  @override
  Future<int> counter() async {
    final db = FirebaseFirestore.instance;
    final snapshot = await db.collection('history').count().get();
    int counter = snapshot.count ?? 0;
    return counter;
  }


}

