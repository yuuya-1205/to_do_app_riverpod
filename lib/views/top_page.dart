import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_to_do_app/repositories/to_do_repository.dart';
import 'package:flutter_riverpod_to_do_app/views/create_post_page.dart';
import 'package:flutter_riverpod_to_do_app/views/edit_post_page.dart';

class TopPage extends ConsumerWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoRepository = ref.watch(toDoRepositoryProvider);
    final posts = ref.watch(todoRepository.postStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoApp'),
      ),
      body: posts.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
          data: (posts) {
            return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Text('タイトル'),
                          Text(post.title),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          EditPostPage(post: post)),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.change_circle),
                              ),
                              IconButton(
                                onPressed: () {
                                  todoRepository.deletePost(post);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('テキスト'),
                          Text(post.text),
                        ],
                      ),
                    ],
                  );
                });
          }),
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
