import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_to_do_app/models/post.dart';
import 'package:flutter_riverpod_to_do_app/repositories/to_do_repository.dart';

final titleProvider = Provider((ref) => TextEditingController());
final textProvider = Provider((ref) => TextEditingController());

class CreatePostPage extends ConsumerWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title0 = ref.watch(titleProvider);
    final text0 = ref.watch(textProvider);
    final todoRepository = ref.watch(toDoRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo作成'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
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
            onPressed: () {
              final title = title0.text;
              final text = text0.text;
              // Update the post instance with the new random ID
              final post = Post(
                id: '',
                text: title,
                title: text,
              );
              todoRepository.addPost(post);
              Navigator.pop(context);
            },
            child: const Text('作成する'),
          )
        ]),
      ),
    );
  }
}
