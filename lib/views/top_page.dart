import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_to_do_app/models/post.dart';
import 'package:flutter_riverpod_to_do_app/views/create_post_page.dart';

class TopPage extends ConsumerWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final value = ref.watch(helloWorldProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoApp'),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: Column(children: [
        const Text('ここにタイムラインを流す'),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const CreatePostPage()),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
