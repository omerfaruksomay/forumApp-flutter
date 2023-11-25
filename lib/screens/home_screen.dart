import 'package:flutter/material.dart';
import 'package:forum_app/components/post_field.dart';
import 'package:forum_app/controllers/authentication.dart';
import 'package:forum_app/controllers/post_contoller.dart';
import 'package:forum_app/screens/post_data.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await _authController.logout();
              },
              icon: const Icon(Icons.logout))
        ],
        centerTitle: true,
        elevation: 0,
        title: const Text('Forum App'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostField(
                hintText: "What do you want to ask?",
                controller: _textController,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                ),
                onPressed: () async {
                  await _postController.createPost(
                      content: _textController.text.trim());
                  _textController.clear();
                  _postController.getAllPosts();
                },
                child: Obx(() {
                  return _postController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Post');
                }),
              ),
              const SizedBox(height: 30),
              const Text(
                'Posts',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              Obx(
                () {
                  return _postController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _postController.posts.value.length,
                          itemBuilder: (context, index) {
                            return PostData(
                              post: _postController.posts.value[index],
                            );
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
