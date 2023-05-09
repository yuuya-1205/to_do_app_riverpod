import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_to_do_app/models/post.dart';

/// 基本的にはこう言うふうにProviderを定義するのはいいと思います。
/// なんでもかんでもProviderにしてしまったほうがいい。
///
/// 理由：
///   - override してモックを注入したい場合に扱いやすい
///   - Providerの中で参照しやすい。
final toDoProvider = Provider<ToDoRepository>((ref) {
  return ToDoRepository();
});

class ToDoRepository {
  static final firestore = FirebaseFirestore.instance;
  static final postCollection = firestore.collection('posts');

  Future<String> addPost(Post post) async {
    final postId = await postCollection.add(post.toJson());
    return post.id;
  }

  static final postStreamProvider = StreamProvider<List<Post>>((ref) {
    final collection = FirebaseFirestore.instance.collection('posts');

    final stream = collection.snapshots().map(
          // CollectionのデータからItemクラスを生成する
          (snap) => snap.docs
              .map((doc) => Post.fromJson(doc.data()).copyWith(id: doc.id))
              .toList(),
        );
    return stream;
  });

  static Future<void> deletePost(Post post) async {
    await postCollection.doc(post.id).delete();
  }

  Future<void> updatePost(Post post) async {
    await postCollection
        .doc(post.id)
        .set(post.toJson(), SetOptions(merge: true));
  }

//   static Future<String> deletePost(Post post) async{

// returns
//   }
}
