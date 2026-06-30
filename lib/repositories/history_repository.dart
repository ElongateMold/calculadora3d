
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
    // 1. Obtenemos el usuario actual
    final uid = FirebaseAuth.instance.currentUser?.uid;
    
    // 2. Si no hay usuario activo, devolvemos 0 por seguridad
    if (uid == null) return 0; 

    final db = FirebaseFirestore.instance;
    
    // 3. Apuntamos a la subcolección correcta del usuario
    final snapshot = await db
        .collection('users')
        .doc(uid)
        .collection('history')
        .count()
        .get();
        
    int counter = snapshot.count ?? 0;
    return counter;
  }


}

