import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_to_do_app/models/post.dart';

class ToDoRepository {
  static final firestore = FirebaseFirestore.instance;
  static final postCollection = firestore.collection('posts');

  static Future<String> addPost(Post post) async {
    final postId = await postCollection.add(post.toJson());
    return post.id;
  }
}
