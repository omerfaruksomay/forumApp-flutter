import 'package:flutter/material.dart';
import 'package:forum_app/components/input_widget.dart';
import 'package:forum_app/controllers/post_contoller.dart';
import 'package:forum_app/models/post_model.dart';
import 'package:forum_app/screens/post_data.dart';
import 'package:get/get.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final TextEditingController _commentController = TextEditingController();
  final PostController _postController = Get.put(PostController());

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postController.getComments(widget.post.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text("Comments of post id: " + widget.post!.id!.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            PostData(post: widget.post),
            Expanded(
              child: Container(
                height: double.infinity,
                child: Obx(() {
                  return _postController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: _postController.comments.value.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              tileColor: Colors.grey[200],
                              title: Text(
                                _postController.comments.value[index].body!,
                              ),
                              subtitle: Text(_postController
                                  .comments.value[index].user!.name!),
                            );
                          },
                        );
                }),
              ),
            ),
            InputWidget(
              hintText: "Comment",
              controller: _commentController,
              obscureText: false,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
              ),
              onPressed: () async {
                await _postController.createComment(
                  widget.post.id,
                  _commentController.text.trim(),
                );
                _commentController.clear();
                _postController.getComments(widget.post.id);
              },
              child: const Text("Comment"),
            )
          ],
        ),
      ),
    );
  }
}
