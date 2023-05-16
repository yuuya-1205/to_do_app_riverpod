import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_to_do_app/firebase_options.dart';
import 'package:flutter_riverpod_to_do_app/models/post.dart';
import 'package:flutter_riverpod_to_do_app/provider/firebase_provider.dart';
import 'package:flutter_riverpod_to_do_app/repositories/to_do_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('postのテスト', () {
    late final ProviderContainer container;

    setUp(() {
      container = ProviderContainer(overrides: [
        firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
      ]);
    });

    test('addPostメソッドテスト', () async {
      ///ここでは引数が必要だが、今回は『テスト』をしているので、自分で作成する。
      ///その値とFirebaseから取得した値が一緒になることを確認する
      const post = Post(
        id: '12345',
        text: 'こんにちは',
        title: 'おはようございます',
      );
      await container.read(toDoRepositoryProvider).addPost(post);
      final posts = await container.read(postStreamProvider.future);

      expect(posts.length, equals(1));
      expect(posts.first.text, equals('こんにちは'));
      expect(posts.first.title, equals('おはようございます'));
      print(posts.length);
      print(posts.first.text);
      print(posts.first.title);

      ///発展的なことをしたければ
      ///RiverPod
      ///postStreamProvider Listen 最初は== null　~空配列
      ///postをAdd呼ぶ
      ///指定したpostが入っているか確認。
      ///Listenがしっかり動いているか確認
      ///
      ///
      ///

      ///画面　WidgetTest 書いてみる。
      ///テストシナリオを自動で書いてくれるもの
      ///
      ///
      ///  verify(listener(null, 0)).called(1);
      // verifyNoMoreInteractions(listener);

      // // ステートの数字を増やす
      // container.read(counterProvider.notifier).state++;

      // // 今度は Listener が `1` で呼び出されているか確認
      // verify(listener(0, 1)).called(1);
      // verifyNoMoreInteractions(listener);

      ///Notiofierとstate　を知る。
      ///
      ///　stateProvider oカウンターアプリ
      ///0→1状態を持っているものstateProvider
      ///；Riverpodの公式サンプルを知らない状態で書けるか？
      ///DBなしで。
    });
  });
}
