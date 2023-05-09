import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_to_do_app/models/post.dart';

/// 基本的にはこう言うふうにProviderを定義するのはいいと思います。
/// なんでもかんでもProviderにしてしまったほうがいい。
///
/// 理由：
///   - override してモックを注入したい場合に扱いやすい
///   - Providerの中で参照しやすい。
final toDoRepositoryProvider = Provider<ToDoRepository>((ref) {
  return ToDoRepository(ref.watch(firestoreProvider));
});

final firestoreProvider = Provider((_) => FirebaseFirestore.instance);

class ToDoRepository {
  /// テストのためにfirestoreを外部から注入したい。
  ///
  /// 外部から注入するとモックを使える。
  ///
  /// そうすると static メソッドは使えなくなります。
  ///
  // static final firestore = FirebaseFirestore.instance;
  ToDoRepository(this.firestore);
  final FirebaseFirestore firestore;

  late final postCollection = firestore.collection('posts');

  /// Post インスタンスを作るときは id に空文字を与えてね。
  /// id はランダムで決まるので、指定することはできない、これらのことがわかるコメントを書くべき。
  Future<String> addPost(Post post) async {
    await postCollection.add(post.toJson());

    /// idはどのように決めるのか、そもそもidは必要なのか。
    ///
    /// id を return したいのはなぜか。
    return post.id;
  }

  final postStreamProvider = StreamProvider<List<Post>>((ref) {
    final collection = FirebaseFirestore.instance.collection('posts');

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
