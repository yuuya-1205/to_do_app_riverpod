import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_to_do_app/models/post.dart';
import 'package:flutter_riverpod_to_do_app/repositories/to_do_repository.dart';

class EditPostPage extends ConsumerWidget {
  const EditPostPage({
    required this.post,
    Key? key,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _title = TextEditingController(text: post.title);
    final _text = TextEditingController(text: post.text);

    final todos = ToDoRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoApp'),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _title,
            ),
            TextFormField(
              controller: _text,
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                final title = _title.text;
                final text = _text.text;
                // Generate a random ID
                final editedPost = Post(
                  id: post.id,
                  text: text,
                  title: title,
                );
                // Update the Firestore data
                todos.updatePost(editedPost);
                Navigator.pop(context);
              },
              child: const Text('編集する'),
            )
          ],
        ),
      ),
    );
  }
}
