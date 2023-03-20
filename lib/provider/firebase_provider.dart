import 'dart:io';
import 'dart:isolate';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:teamup/model/user.dart';
import 'package:path/path.dart' as path;

class FirebaseProvider {

  FirebaseProvider();

  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception');
    return user;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  FirebaseStorage get storage => FirebaseStorage.instance;

  Future<MyUser?> getMyUser() async {
    final snapshot = await firestore.doc('user/${currentUser.uid}').get();
    if (snapshot.exists) return MyUser.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  Future<void> saveMyUser(MyUser user, File? image) async {
    final ref = firestore.doc('user/${currentUser.uid}');
    if (image != null) {
      final imagePath =
          '${currentUser.uid}/profile/${path.basename(image.path)}';
      final storageRef = storage.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      await ref.set(user.toFirebaseMap(newImage: url), SetOptions(merge: true));
    } else {
      await ref.set(user.toFirebaseMap(), SetOptions(merge: true));
    }
  }

  Future<List<MyUser>> getUsers() async {
    
    List<MyUser> users = [];
      try {

        final pla = await firestore.collection('user').get();
        // ignore: avoid_function_literals_in_foreach_calls
        pla.docs.forEach((element) {

          return users.add(MyUser.fromFirebaseMap(element.data()));
        });
        return users;      
      
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Failed with error ${e.code}: ${e.message}');
      }
      return users;
    } catch (e) {
      throw Exception(e.toString());
    }
    
  }
}
