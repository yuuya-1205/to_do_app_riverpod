import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_to_do_app/models/post.dart';
import 'package:flutter_riverpod_to_do_app/repositories/to_do_repository.dart';

class EditPostPage extends ConsumerStatefulWidget {
  const EditPostPage({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPostPageState();
}

class _EditPostPageState extends ConsumerState<EditPostPage> {
  late final title0 = TextEditingController(text: widget.post.title);
  late final text0 = TextEditingController(text: widget.post.text);
  @override
  Widget build(BuildContext context) {
    final todoRepository = ref.watch(toDoRepositoryProvider);
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
              controller: title0,
            ),
            TextFormField(
              controller: text0,
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                final title = title0.text;
                final text = text0.text;
                // Generate a random ID
                final editedPost = Post(
                  id: widget.post.id,
                  text: text,
                  title: title,
                );
                // Update the Firestore data
                todoRepository.updatePost(editedPost);
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
