import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_to_do_app/models/post.dart';

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final postStreamProvider = StreamProvider<List<Post>>((ref) {
  final firebaseFirestore = ref.watch(firebaseFirestoreProvider);
  final collection = firebaseFirestore.collection('posts');

  final stream = collection.snapshots().map(
        // CollectionのデータからItemクラスを生成する
        (snap) => snap.docs
            .map((doc) => Post.fromJson(doc.data()).copyWith(id: doc.id))
            .toList(),
      );
  return stream;
});
