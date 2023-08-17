import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

final String USER_COLLECTION = 'users';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Map? currentUser;

  FirebaseService();

 //function to comunicate with firebased auth
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      //login our user
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      //checking user loging    
      if (_userCredential.user != null) {
        currentUser = await getUserData(uid: _userCredential.user!.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    } 
  }

 //get user id
  Future<Map> getUserData({required String uid}) async {
   DocumentSnapshot _doc = await _db.collection(USER_COLLECTION).doc(uid).get();
   return _doc.data() as Map;
  }


}
