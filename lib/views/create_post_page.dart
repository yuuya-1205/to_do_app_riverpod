import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_to_do_app/models/post.dart';
import 'package:flutter_riverpod_to_do_app/repositories/to_do_repository.dart';

class CreatePostPage extends ConsumerWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _titleProvider = Provider((ref) => TextEditingController());
    final _textProvider = Provider((ref) => TextEditingController());
    final _title = ref.watch(_titleProvider);
    final _text = ref.watch(_textProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo作成'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
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
              final post = Post(
                id: '',
                title: title,
                text: text,
              );
              await ToDoRepository.addPost(post);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child: const Text('作成する'),
          )
        ]),
      ),
    );
  }
}
