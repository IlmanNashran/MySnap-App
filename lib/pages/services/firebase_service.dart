import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

final String USER_COLLECTION = 'users';
final String POST_COLLECTION = 'posts';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Map? currentUser;

  FirebaseService();

//setup register firebase
  Future<bool> registerUser({
    required String name,
    required String password,
    required String email,
    required File image,
  }) async {
    try {
      UserCredential _userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email, password: password); //create user iin firebase
      String _userId = _userCredential.user!.uid; //get user id
      String _fileName = Timestamp.now().microsecondsSinceEpoch.toString() +
          p.extension(image.path); //create file to upload
      UploadTask _task = _storage
          .ref('images/$_userId/$_fileName')
          .putFile(image); //define task for upload file
      return _task.then((_snapshot) async {
        String _downloadURL = await _snapshot.ref
            .getDownloadURL(); //after task complete get download url
        await _db.collection(USER_COLLECTION).doc(_userId).set({
          //create user
          "name": name,
          "email": email,
          "image": _downloadURL,
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

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
    DocumentSnapshot _doc =
        await _db.collection(USER_COLLECTION).doc(uid).get();
    return _doc.data() as Map;
  }

  //post function to save in firebase
  Future<bool> postImage(File _image) async {
    try {
      String _userId = _auth.currentUser!.uid;
      String _fileName = Timestamp.now().microsecondsSinceEpoch.toString() +
          p.extension(_image.path);
      UploadTask _task =
          _storage.ref('images/$_userId/$_fileName ').putFile(_image);
      return await _task.then((_snapshot) async {
        String _downloadURL = await _snapshot.ref.getDownloadURL();
        await _db.collection(POST_COLLECTION).add({
          //add post to db
          "userId": _userId,
          "timestamp": Timestamp.now(),
          "image": _downloadURL,
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  //show picture from firebase
  Stream<QuerySnapshot> getLatestPosts() {
   return _db
        .collection(POST_COLLECTION)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
