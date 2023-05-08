import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_to_do_app/models/post.dart';

class PostNotifier extends StateNotifier<Post> {
  // 初期値の指定
  PostNotifier() : super(const Post());

  // メインカウントを+1する
  void increaseMainCount() async {
    state = state.copyWith(title: state.title);
  }

  // サブカウントを+1する
  void increaseSubCount() async {
    state = state.copyWith(text: state.text);
  }

  // すべてのカウントを0に戻す
  // void resetAllCount() async {
  //   state = state.copyWith(
  //     mainCount: 0,
  //     subCount: 0,
  //   );
  // }
}

final postProvider = StateNotifierProvider.autoDispose<PostNotifier, Post>(
  (ref) => PostNotifier(),
);
