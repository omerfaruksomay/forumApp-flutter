import 'package:flutter/material.dart';
import 'package:forum_app/controllers/post_contoller.dart';
import 'package:forum_app/models/post_model.dart';
import 'package:forum_app/screens/post_details_screen.dart';
import 'package:get/get.dart';

class PostData extends StatefulWidget {
  const PostData({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final PostController _postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.user!.name!,
            style: TextStyle(fontSize: 19),
          ),
          Text(
            widget.post.user!.email!,
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 10),
          Text(widget.post.content!),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await _postController.likeController(widget.post.id);
                  _postController.getAllPosts();
                },
                icon: Icon(
                  Icons.thumb_up,
                  color: widget.post.liked! ? Colors.blue : Colors.black,
                ),
              ),
              IconButton(
                  onPressed: () {
                    Get.to(() => PostDetails(
                          post: widget.post,
                        ));
                  },
                  icon: const Icon(Icons.message))
            ],
          ),
        ],
      ),
    );
  }
}
