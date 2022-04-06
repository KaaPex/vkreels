import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vk_reels/presentation/animation/expandable_text.dart';
import 'package:vk_sdk/vk_sdk.dart';

class PostWidget extends StatefulWidget {
  final VKPost post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
        ),
        color: Theme.of(context).primaryColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // Header section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: null,
                  child: const Icon(
                    Icons.person,
                  ),
                )
              ],
            ),
          ),
          // context
          GestureDetector(
            onDoubleTap: () {
              //TODO: like/dislike post
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: const Icon(Icons.image),
                ),
                AnimatedOpacity(
                  opacity: isLikeAnimating ? 1 : 0,
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  child: const Icon(Icons.favorite_border),
                )
              ],
            ),
          ),
          // footer section (likes, comments, reposts, views)
          Row(
            children: [
              const Icon(Icons.favorite),
            ],
          ),
          // footer descriptions
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // author and description
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: ExpandableText(
                      author: '${widget.post.ownerId}',
                      text: widget.post.text ?? '',
                    )),
                // created date
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  width: double.infinity,
                  child: Text(
                    DateFormat.yMMMd().format(widget.post.date!),
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
