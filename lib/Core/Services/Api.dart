import 'package:cloud_firestore/cloud_firestore.dart';

class Api{
  final Firestore _firestore = Firestore.instance;
  final String collectionName;
  CollectionReference _firestoreCollection;
  Api(this.collectionName){
    _firestoreCollection = _firestore.collection(collectionName);
  }
  Future<QuerySnapshot> getCollectionDocs() {
    return _firestoreCollection.getDocuments();
  }
  Stream<QuerySnapshot> getCollectionDocsAsStream(){
    return _firestoreCollection.snapshots();
  }
  Future<DocumentSnapshot> getDocumentById(String id){
    return _firestoreCollection.document(id).get();
  }
  Future<DocumentReference> addDocument(Map data){
    return _firestoreCollection.add(data);
  }
  
  deleteDocument(String id){
    _firestoreCollection.document(id).delete();
  }
  updateDocument(String id,Map data){
    _firestoreCollection.document(id).updateData(data);
  }
}