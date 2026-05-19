
import 'package:cloud_firestore/cloud_firestore.dart';

// Separación de clases 
// Solo define qué hace
abstract class HistoryRepository {
  Future<void> savePrint(Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> readPrint();
  Future<int> counter();
}

class FirebaseHistory implements HistoryRepository {
  @override
  Future<void> savePrint(Map<String, dynamic> data) async {
    final db = FirebaseFirestore.instance;
    await db.collection('history').add(data);
  }
  
  @override
  Future<List<Map<String, dynamic>>> readPrint() async {
    final db = FirebaseFirestore.instance;
    final snapshot = await db.collection('history').get();
    List<Map<String, dynamic>> listHistory = [];

    for (var doc in snapshot.docs) {
      listHistory.add(doc.data());
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

