import 'package:flutter/material.dart';
import 'package:flutter_riverpod_to_do_app/views/create_post_page.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
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
