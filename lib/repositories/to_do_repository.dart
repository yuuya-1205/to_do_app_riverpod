import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_to_do_app/models/post.dart';

final toDoRepositoryProvider = Provider<ToDoRepository>((ref) {
  return ToDoRepository(ref.watch(firestoreProvider));
});

final firestoreProvider = Provider((_) => FirebaseFirestore.instance);

class ToDoRepository {
  ToDoRepository(this.firestore);
  final FirebaseFirestore firestore;
  late final postCollection = firestore.collection('posts');

  Future<String> addPost(Post post) async {
    await postCollection.add(post.toJson());
    return post.id;
  }

  late final postStreamProvider = StreamProvider<List<Post>>((ref) {
    final collection = firestore.collection('posts');

    final stream = collection.snapshots().map(
          // CollectionのデータからItemクラスを生成する
          (snap) => snap.docs
              .map((doc) => Post.fromJson(doc.data()).copyWith(id: doc.id))
              .toList(),
        );
    return stream;
  });

  Future<void> deletePost(Post post) async {
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
