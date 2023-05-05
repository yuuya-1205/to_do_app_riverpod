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

  static final postStreamProvider = StreamProvider<List<Post>>((ref) {
    final collection = FirebaseFirestore.instance.collection('posts');

    final stream = collection.snapshots().map(
          // CollectionのデータからItemクラスを生成する
          (e) => e.docs.map((e) => Post.fromJson(e.data())).toList(),
        );
    return stream;
  });

//   static Future<String> deletePost(Post post) async{

// return
//   }
}
